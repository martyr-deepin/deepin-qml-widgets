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
import Deepin.Widgets 1.0

Item {
    id: combobox
    // width: Math.max(minMiddleWidth, parent.width)
    height: background.height

    property bool hovered: false
    property bool pressed: false

    // text property is deprecated, use value instead
    property var text: ""
    property alias value: combobox.text
    property alias menu: menu
    // labels property is deprecated, use itemModel instead
    property alias labels: menu.labels

    property var parentWindow
    property alias selectIndex: menu.currentIndex

    property Component delegate: Component {
        DssH2 { text: combobox.value; elide: Text.ElideRight }
    }
    property alias itemDelegate: menu.delegate
    property alias itemModel: menu.labels

    signal clicked
    signal menuSelect(int index)

    function select(index) {
        if(index != -1 && itemModel){
            value = itemModel[index]
        }
    }

    onSelectIndexChanged: select(selectIndex)

    Component.onCompleted: select(selectIndex)

    DMenu {
        id: menu
        parentWindow: combobox.parentWindow
        onMenuSelect: {
            combobox.select(index)
            combobox.menuSelect(index)
        }
    }

    function showMenu(x, y, w) {
        menu.x = x - menu.frameEdge + 1
        menu.y = y - menu.frameEdge - combobox.height
        menu.width = w + menu.frameEdge * 2 -2
        menu.showMenu()
    }

    function hideMenu() {
        menu.visible = false
    }

    onClicked: {
        var pos = mapToItem(null, 0, 0)
        var x = parentWindow.x + pos.x
        var y = parentWindow.y + pos.y + height
        var w = width
        showMenu(x, y, w)
    }

    DButtonFrame{
        id: background
        width: parent.width
    }

    Rectangle {
        id: content
        width: parent.width - DPalette.textLeftMargin - DPalette.textRightMargin
        height: background.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Loader {
            id: button_loader
            sourceComponent: combobox.delegate
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            onLoaded: {
                item.width = Qt.binding(function() { return content.width - downArrow.width })
            }
        }

        Image {
            id: downArrow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            source: hovered ? DPalette.imagesPath + "arrow_down_hover.png" : DPalette.imagesPath + "arrow_down_normal.png"
        }

    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            parent.hovered = true
        }

        onExited: {
            parent.hovered = false
        }

        onPressed: {
            parent.pressed = true
        }
        onReleased: {
            parent.pressed = false
            parent.hovered = containsMouse
        }

        onClicked: {
            combobox.clicked()
        }
    }
}
