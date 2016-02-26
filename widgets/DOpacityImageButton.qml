/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1

Image {
    id: actionButton

    opacity: 0.5
    property alias mouseArea: mouseArea

    signal clicked
    
    states: State {
        name: "hovered"
        PropertyChanges { target: actionButton; opacity: 1.0 }
    }
    
    transitions: Transition {
        NumberAnimation { properties: "opacity"; duration: 350 }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: actionButton
        hoverEnabled: true
        
        onEntered: {
            actionButton.state = "hovered"
            mouseArea.cursorShape = Qt.PointingHandCursor
        }
        
        onExited: {
            actionButton.state = ""
            mouseArea.cursorShape = Qt.ArrowCursor
        }
        
        onReleased: { 
            actionButton.state = mouseArea.containsMouse ? "hovered" : ""
        }
        onClicked: {
            parent.clicked()
        }
    }
}
