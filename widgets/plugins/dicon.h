/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#ifndef DICON_H
#define DICON_H

#include <QQuickPaintedItem>
#include <QPainter>

class DIcon : public QQuickPaintedItem
{
    Q_OBJECT
    Q_DISABLE_COPY(DIcon)

    Q_PROPERTY(QString theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(QString icon READ icon WRITE setIcon NOTIFY iconChanged)

public:
    DIcon(QQuickPaintedItem *parent = 0);
    ~DIcon();

    const QString& theme() { return m_theme; }
    void setTheme(const QString& v);
    Q_SIGNAL void themeChanged(QString);

    const QString& icon() { return m_icon; }
    void setIcon(const QString& v);
    Q_SIGNAL void iconChanged(QString);

    void paint(QPainter *painter);

    QString iconNameToPath(QString qname, int size);

private:
    QString m_icon;
    QString m_theme;
};

#endif // DICON_H
