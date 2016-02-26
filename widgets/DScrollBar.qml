/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0;
import Deepin.Widgets 1.0

Item {
    id: scrollbar
    width: handleSize
    height: parent.height
    visible: (flickable.visibleArea.heightRatio < 1.0)
    anchors.right: parent.right

    property Flickable flickable : null
    property int handleSize: DPalette.scrollBarStyle.width
    property alias backHandle: backHandle
    property color inactiveColor: DPalette.scrollBarStyle.inactiveColor
    property color activeColor: DPalette.scrollBarStyle.activeColor
    property bool inInteractive: false

    function scrollDown () {
        flickable.contentY = Math.min (flickable.contentY + (flickable.height / 4), flickable.contentHeight - flickable.height)
    }
    function scrollUp () {
        flickable.contentY = Math.max (flickable.contentY - (flickable.height / 4), 0)
    }

    function handleShow(){
        backHandle.opacity = 0.7
        backHandle.color = activeColor
        scrollbar.inInteractive = true
    }

    function handleHide(){
        if (hideTimer.running){
            hideTimer.stop()
        }
        hideTimer.restart()
        backHandle.color = inactiveColor
        scrollbar.inInteractive = false
    }

    Binding {
        target: handle
        property: "y"
        value: (flickable.contentY * clicker.drag.maximumY / (flickable.contentHeight - flickable.height))
        when: (!clicker.drag.active)
    }

    Binding {
        target: flickable
        property: "contentY"
        value: (handle.y * (flickable.contentHeight - flickable.height) / clicker.drag.maximumY)
        when: (clicker.drag.active || clicker.pressed)
    }

    Connections {
        target: handle
        onYChanged: {
            handleShow()
            handleHide()
        }
    }

    Item {
        id: groove
        clip: true
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            drag.target: handle
            drag.axis: Drag.YAxis
            drag.minimumY: 0
            drag.maximumY: (groove.height - handle.height)
            drag.filterChildren: true

            onClicked: {
                flickable.contentY = (mouse.y / groove.height * (flickable.contentHeight - flickable.height))
            }

            onEntered: {
                handleShow()
            }

            onExited: {
                handleHide()
            }
        }

        Item {
            id: handle
            height: Math.max(50, (flickable.visibleArea.heightRatio * groove.height))
            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: backHandle
                color: scrollbar.inactiveColor
                anchors { fill: parent }
                border.color: DPalette.scrollBarStyle.borderColor
                border.width: 1
                radius: 6
                opacity: 0

                Behavior on opacity { NumberAnimation { duration: 150 } }
            }

            MouseArea {
                id: clicker
                anchors.fill: parent
                hoverEnabled: true

                drag.target: handle
                drag.axis: Drag.YAxis
                drag.minimumY: 0
                drag.maximumY: (groove.height - handle.height)
                drag.filterChildren: true

                onPressed: {
                }

                onEntered: {
                    handleShow()
                }

                onExited: {
                    handleHide()
                }
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 150
        repeat: false
        onTriggered: {
            if (!scrollbar.inInteractive) {
                backHandle.opacity = 0
            }
        }
    }
}
