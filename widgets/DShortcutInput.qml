/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1
import Deepin.Widgets 1.0

DTextInput {
    id: input
    readOnly: true
    text: shortcut || noneString
    keyboardOperationsEnabled: false


    property string shortcut: "shortcut"
    property string noneString
    property string promoteString

    signal shortcutSet (string shortcut)
    signal shortcutDisabled

    function shortcutToText(shortcut) {
        return shortcut ? KeysUtils.getOverriddenShortcut(shortcut) : noneString
    }

    onShortcutSet: text = shortcutToText(shortcut)
    // below line is necessary, it will prevent other operations from breaking
    // the binding of hotKey to text
    onShortcutChanged: text = shortcutToText(shortcut)
    onActiveFocusChanged: text = activeFocus ? promoteString : shortcutToText(shortcut)

    onKeyPressed: {
        var modifiers = [Qt.Key_Control, Qt.Key_Shift, Qt.Key_Alt, Qt.Key_Meta, Qt.Key_AltGr, Qt.Key_Super_L, Qt.Key_Super_R]
        if (modifiers.indexOf(event.key) == -1) {
            input.focus = false
            if (event.key != Qt.Key_Backspace) {
                input.shortcutSet(KeysUtils.keyEventToString(event.modifiers, event.key))
            } else {
                input.shortcutDisabled()
            }
        }
    }
}
