/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#ifndef DPREVIEWWINDOW_H
#define DPREVIEWWINDOW_H

#include <QAbstractNativeEventFilter>
#include <QQuickItem>
#include <QMutex>
#include <QPointer>

class DPreviewWindow : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(DPreviewWindow)
    Q_PROPERTY(quint32 xid READ xid WRITE setXid NOTIFY xidChanged)

public:
    DPreviewWindow(QQuickItem *parent = 0);
    ~DPreviewWindow();

    quint32 xid() { return m_xid; }
    void setXid(quint32 xid);
    Q_SIGNAL void xidChanged(quint32);
private:

    Q_SLOT void onXidChanged(quint32 xid);

    friend class Monitor;

    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);
    void markDamaged() { m_damaged=true;}
    void bindTexture();
    quint32 pixmap() { return m_pixmap; }
    void updatePixmap();
    void releasePixmap();
    void updateWinSize(quint32 width, quint32 height);
    QRect getDisplayRect();

    quint16 win_width;
    quint16 win_height;
    quint32 m_xid;
    quint32 m_texture;
    quint32 m_pixmap;
    quint32 m_glx_pixmap;
    quint32 m_fbconfig;
    bool m_damaged;
};
#endif // DPREVIEWWINDOW_H

