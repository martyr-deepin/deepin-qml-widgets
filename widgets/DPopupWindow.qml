/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

//Use DWindow or DOverrideWindow will cause DComboBox Exception crash in some situation when use it in DMenu
Window {
    id: win
    width: 400
    height: 300
    color: "transparent"

    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.X11BypassWindowManagerHint

    onVisibleChanged: {
        if(visible){
            raise()
        }
    }

    property var parentWindow: null

    function isInRect(pos, rect){
        if(pos.x > rect.x && pos.x < rect.x + rect.width && pos.y > rect.y && pos.y < rect.y + rect.height){
            return true
        }
        else{
            return false
        }
    }

    Connections{
        target: parentWindow
        onWindowFocusChanged: {
            if(!window && win.visible){
                win.visible = false
            }
        }

        onMousePressed: {
            var pos = parentWindow.getCursorPos()
            if(!isInRect(pos, win)){
                win.visible = false
            }
        }

        onWheel: {
            var pos = parentWindow.getCursorPos()
            if(!isInRect(pos, win)){
                win.visible = false
            }
        }
    }
}
