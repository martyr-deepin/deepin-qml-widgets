/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "plugins/dwindow.h"
#include <QCursor>
#include <QX11Info>
#include <QScreen>

#include <cstdio>
#include <cstring>

DOverrideWindow::DOverrideWindow(DWindow *parent)
    :DWindow(parent)
{
    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);

    this->setFlags(Qt::Popup|Qt::FramelessWindowHint);
}

DOverrideWindow::~DOverrideWindow()
{
}

DWindow::DWindow(QQuickWindow *parent)
    :QQuickWindow(parent)
{
    _conn = QX11Info::connection();

    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);

    connect(qApp, SIGNAL(focusWindowChanged(QWindow*)), this, SLOT(focusChanged(QWindow *)));
    connect(this, SIGNAL(visibilityChanged(QWindow::Visibility)), this, SLOT(visibilityChangedSlot(QWindow::Visibility)));
    connect(this, SIGNAL(screenChanged(QScreen*)), this, SLOT(handlerScreenChanged(QScreen*)));
}

DWindow::~DWindow()
{
}

int DWindow::shadowWidth()
{
    return _shadowWidth;
}

void DWindow::setShadowWidth(int shadowWidth)
{
    _shadowWidth = shadowWidth;
    char shadowWidthStr[8];
    sprintf(shadowWidthStr, "%d", shadowWidth);

    xcb_intern_atom_cookie_t cookie;
    xcb_intern_atom_reply_t *reply;

    cookie = xcb_intern_atom(_conn, false, strlen("DEEPIN_WINDOW_SHADOW"),
                             "DEEPIN_WINDOW_SHADOW");
    if ((reply = xcb_intern_atom_reply(_conn, cookie, NULL))) {

        xcb_change_property_checked(_conn, XCB_PROP_MODE_REPLACE, this->winId(),
                                    reply->atom, XCB_ATOM_STRING, 8, strlen(shadowWidthStr),
                                    shadowWidthStr);
        xcb_flush(_conn);

        free(reply);
    }

    emit shadowWidthChanged(shadowWidth);
}

QPoint DWindow::getCursorPos()
{
    return QCursor::pos();
}

void DWindow::focusChanged(QWindow *win)
{
    Q_EMIT windowFocusChanged(win);
}

void DWindow::handlerScreenChanged(QScreen *s)
{
    if(s == 0){
        Q_EMIT qt5ScreenChanged();
    }
}

void DWindow::mousePressEvent(QMouseEvent *ev){
    QPointF p = QPointF(ev->x(), ev->y());
    DWindow::mousePressed(p);
    QQuickWindow::mousePressEvent(ev);
}

void DWindow::wheelEvent(QWheelEvent *ev) {
    emit wheel(QPointF(ev->x(), ev->y()));
    QQuickWindow::wheelEvent(ev);
}

void DWindow::visibilityChangedSlot(QWindow::Visibility visibility)
{
    if(visibility != QWindow::Hidden) {
        this->setShadowWidth(_shadowWidth);
    }
}

int DWindow::getWinId()
{
    return QString("%1").arg(this->winId()).toInt();
}
