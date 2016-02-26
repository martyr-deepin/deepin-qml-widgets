/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#ifndef KEYSUTILS_H
#define KEYSUTILS_H

#include <QObject>
#include <QVariantMap>

class KeysUtils : public QObject
{
    Q_OBJECT
public:
    explicit KeysUtils(QObject *parent = 0);

public slots:
    // keys related
    void overrideShortcut(QString oldShortcut, QString newShortcut);
    QString getOverriddenShortcut(QString shortcut);
    QString keyEventToString(int modifiers, int key);
    bool isKeyEventEqualToString(int modifiers, int key, QString targetString);

private:
    QVariantMap m_overriddenShortcuts;
};

#endif // KEYSUTILS_H
