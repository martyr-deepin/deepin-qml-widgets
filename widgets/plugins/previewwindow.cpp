/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "previewwindow.h"
#include <QSGSimpleRectNode>
#include <QSGMaterialShader>
#include <QSGSimpleTextureNode>
#include <QGuiApplication>
#include <QQuickWindow>
#include <QScreen>
#include <QOpenGLContext>
#include <QSGTexture>
#include <QSGTextureProvider>
#include <GL/glx.h>
#include <X11/extensions/Xcomposite.h>
#include <X11/extensions/Xdamage.h>
#include <xcb/xcb.h>
#include <xcb/damage.h>
#include <QX11Info>

template<class Key, class T>
class CountedMap : private QMap<Key, T> {
public:
    void remove(const Key &key) {
	if (!QMap<Key, T>::contains(key)) {
	    return;
	}
	quint32 count = m_counts[key];
	if (count == 1) {
	    m_counts.remove(key);
	    QMap<Key,T>::remove(key);
	}

	m_counts[key]--;
    }
    void insert(const Key &key, const T &value) {
	if (!QMap<Key,T>::contains(key)) {
	    QMap<Key,T>::insert(key, value);
	}
	m_counts[key]++;
    }
    const T value(const Key &key) const {
	return QMap<Key,T>::value(key);
    }
    bool contains(const Key &key) {
	return QMap<Key,T>::contains(key);
    }
private:
    QMap<Key, quint32> m_counts;
};

class Monitor : public QAbstractNativeEventFilter {
public:
    static Monitor* instance();
    static void drop();

    void add(QPointer<DPreviewWindow>);
    void remove(QPointer<DPreviewWindow>);

private:
    Monitor();
    Monitor(const Monitor&);
    Monitor& operator=(const Monitor&);

    QMap<quint32, QPointer<DPreviewWindow> > m_windows;
    CountedMap<quint32, quint32> m_damages;

    static Monitor* m_instance;

    virtual bool nativeEventFilter(const QByteArray &eventType, void *message, long int *result);
    int m_damageEventBase;

    QMutex locker;
};


static PFNGLXBINDTEXIMAGEEXTPROC glXBindTexImageEXT_func = NULL;
static PFNGLXRELEASETEXIMAGEEXTPROC glXReleaseTexImageEXT_func = NULL;

void initGLXfunc()
{
    static bool init = false;
    if (!init) {
	init = true;
	const char *ext = glXQueryExtensionsString(QX11Info::display(), QX11Info::appScreen());
	if (!strstr(ext, "GLX_EXT_texture_from_pixmap")) {
	    qDebug() << "GLX_EXT_texture_from_pixmap not supported.";
	}

	glXBindTexImageEXT_func = (PFNGLXBINDTEXIMAGEEXTPROC) glXGetProcAddress((GLubyte *) "glXBindTexImageEXT");
	glXReleaseTexImageEXT_func = (PFNGLXRELEASETEXIMAGEEXTPROC) glXGetProcAddress((GLubyte*) "glXReleaseTexImageEXT");

	if (!glXBindTexImageEXT_func || !glXReleaseTexImageEXT_func) {
	    qDebug() << "glXGetProcAddress failed!";
	}
    }
}

DPreviewWindow::DPreviewWindow(QQuickItem *parent)
        :QQuickItem(parent),
        m_xid(0),
        m_pixmap(0),
        m_damaged(true)
{
    setFlag(ItemHasContents, true);
    initGLXfunc();
    connect(this, &DPreviewWindow::xidChanged, this, &DPreviewWindow::onXidChanged);
}
DPreviewWindow::~DPreviewWindow()
{
    Monitor::instance()->remove(QPointer<DPreviewWindow>(this));
}


void DPreviewWindow::updateWinSize(quint32 width, quint32 height)
{
    if (width != this->win_width || height != this->win_height) {
	this->win_width = width;
	this->win_height = height;
	this->releasePixmap();
    }
}

QRect DPreviewWindow::getDisplayRect()
{
    double ratio = win_width * 1.0 / win_height;

    int w = 0, h = 0;
    if (win_width > win_height) {
	w = width();
	h = height() / ratio;
    } else {
	w = width() * ratio;
	h = height();
    }

    int x = (width() - w) / 2;
    int y = (height() - h) / 2;
    return QRect(x,y,w,h);
}

void DPreviewWindow::setXid(quint32 xid)
{
    m_xid = xid;
    Q_EMIT xidChanged(m_xid);
}

void DPreviewWindow::onXidChanged(quint32 xid)
{
    Window root = 0;
    int x, y;
    unsigned int width, height, border, depth;
    if (XGetGeometry(QX11Info::display(), xid, &root, &x, &y, &width, &height, &border,&depth)) {
	Monitor::instance()->remove(QPointer<DPreviewWindow>(this));
	updateWinSize(width, height);
	Monitor::instance()->add(QPointer<DPreviewWindow>(this));
    } else {
	qDebug() << "window of " << xid << "is invalid";
    }

}

void DPreviewWindow::updatePixmap()
{
    if (m_pixmap == 0) {
	XCompositeRedirectWindow(QX11Info::display(), m_xid, CompositeRedirectAutomatic);
	m_pixmap = XCompositeNameWindowPixmap(QX11Info::display(), m_xid);
    }
    bindTexture();
}
void DPreviewWindow::bindTexture()
{
    int config;
    glXQueryContext(QX11Info::display(), glXGetCurrentContext(), GLX_FBCONFIG_ID, &config);
    int attrs[] = { GLX_FBCONFIG_ID, config, 0 };
    int n;
    GLXFBConfig* fbConfigs = glXChooseFBConfig(QX11Info::display(), QX11Info::appScreen(), attrs, &n);

    const int pixmapAttribs[] = {
            GLX_TEXTURE_TARGET_EXT, GLX_TEXTURE_2D_EXT,
            GLX_TEXTURE_FORMAT_EXT, GLX_TEXTURE_FORMAT_RGBA_EXT,
            0
    };

    if (m_glx_pixmap == 0) {
        m_glx_pixmap = (uint32_t)glXCreatePixmap(QX11Info::display(), fbConfigs[0], m_pixmap, pixmapAttribs);
    }
}



QSGNode* DPreviewWindow::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData*)
{
    QSGSimpleTextureNode* node = static_cast<QSGSimpleTextureNode*>(oldNode);
    if (!node) {
	node = new QSGSimpleTextureNode;
	node->setFiltering(QSGTexture::Nearest);

	node->markDirty(QSGNode::DirtyMaterial);
    }

    updatePixmap();

    QSGTexture* t = window()->createTextureFromId(m_glx_pixmap,  QSize(width(), height()));
    t->bind();
    glXBindTexImageEXT_func(QX11Info::display(), m_glx_pixmap, GLX_FRONT_EXT, NULL);

    node->setTexture(t);
    node->setRect(getDisplayRect());

    node->markDirty(QSGNode::DirtyMaterial);
    if (m_damaged) {
	node->markDirty(QSGNode::DirtyGeometry);
	m_damaged = false;
    }
    return node;
}

void DPreviewWindow::releasePixmap()
{
    if (m_glx_pixmap) {
        auto *d = QX11Info::display();
        glXReleaseTexImageEXT_func(d, m_glx_pixmap, GLX_FRONT_LEFT_EXT);
        glXDestroyPixmap(d, m_glx_pixmap);
        m_glx_pixmap = 0;
        glDeleteTextures(1, &m_texture);
    }
    if (m_pixmap) {
        XFreePixmap(QX11Info::display(), m_pixmap);
        m_pixmap = 0;
    }
    m_damaged = true;
}


Monitor::Monitor():
        QAbstractNativeEventFilter()
{
    if (QGuiApplication *gui = dynamic_cast<QGuiApplication*>(QCoreApplication::instance())) {
        gui->installNativeEventFilter(this);
        xcb_connection_t *c = QX11Info::connection();
        xcb_prefetch_extension_data(c, &xcb_damage_id);
        const auto *reply = xcb_get_extension_data(c, &xcb_damage_id);
        m_damageEventBase = reply->first_event;
        if (reply->present) {
            xcb_damage_query_version_unchecked(c, XCB_DAMAGE_MAJOR_VERSION, XCB_DAMAGE_MINOR_VERSION);
        }
    }
}

void Monitor::add(QPointer<DPreviewWindow> w)
{
    locker.lock();
    if (!m_damages.contains(w->xid())) {
	auto *c = QX11Info::connection();

	int damage = xcb_generate_id(c);
	xcb_damage_create(c, damage, w->xid(), XCB_DAMAGE_REPORT_LEVEL_RAW_RECTANGLES);

	const uint32_t values[] = {XCB_EVENT_MASK_STRUCTURE_NOTIFY};
	xcb_change_window_attributes(c, w->xid(), XCB_CW_EVENT_MASK, values);

	m_damages.insert(w->xid(), damage);
	m_windows[w->xid()] = w;
    }
    locker.unlock();
}

void Monitor::remove(QPointer<DPreviewWindow> w)
{
    locker.lock();
    if (m_damages.contains(w->xid())) {
	int damage = m_damages.value(w->xid());
	xcb_damage_destroy(QX11Info::connection(), damage);
	m_windows.remove(w->xid());
	m_damages.remove(w->xid());
    }
    locker.unlock();
}

bool Monitor::nativeEventFilter(const QByteArray &eventType, void *message, long *result)
{
    Q_UNUSED(result);
    if (eventType=="xcb_generic_event_t") {
	xcb_generic_event_t *event = static_cast<xcb_generic_event_t*>(message);
	const uint8_t responseType = event->response_type & ~0x80;
	if (responseType == m_damageEventBase + XCB_DAMAGE_NOTIFY) {
	    auto *ev = reinterpret_cast<xcb_damage_notify_event_t*>(event);
	    auto window = m_windows[quint32(ev->drawable)];
	    if (window) {
		window->markDamaged();
		window->update();
	    }
	} else if (responseType == XCB_CONFIGURE_NOTIFY) {
	    auto *ev = reinterpret_cast<xcb_configure_notify_event_t*>(event);
	    auto window = m_windows[ev->window];
	    if (window) {
		window->updateWinSize(ev->width, ev->height);
		window->update();
	    }
	}
    }
    return false;
}

Monitor* Monitor::m_instance = 0;

Monitor* Monitor::instance()
{
    static QMutex mutex;
    if (!m_instance) {
        mutex.lock();
        if (!m_instance) {
            m_instance = new Monitor;
        }
        mutex.unlock();
    }
    return m_instance;
}
void Monitor::drop()
{
    static QMutex mutex;
    mutex.lock();
    delete m_instance;
    m_instance = 0;
    mutex.unlock();
}
