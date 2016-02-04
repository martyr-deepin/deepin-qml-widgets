/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "keysutils.h"
#include <QKeySequence>

KeysUtils::KeysUtils(QObject *parent) :
    QObject(parent)
{
    // add overridden keys
    overrideShortcut("Meta", "Super");
    overrideShortcut("PgUp", "PageUp");
    overrideShortcut("PgDown", "PageDown");
}

void KeysUtils::overrideShortcut(QString oldShortcut, QString newShortcut)
{
    m_overriddenShortcuts[oldShortcut] = newShortcut;
}

QString KeysUtils::getOverriddenShortcut(QString shortcut)
{
    return m_overriddenShortcuts.value(shortcut, shortcut).value<QString>();
}

QString KeysUtils::keyEventToString(int modifiers, int key)
{
    QString sequence = QKeySequence(modifiers + key).toString();
    return getOverriddenShortcut(sequence);
}

bool KeysUtils::isKeyEventEqualToString(int modifiers, int key, QString targetString)
{
    QString sequence = QKeySequence(modifiers + key).toString();
    return sequence == targetString || sequence == getOverriddenShortcut(targetString);
}
