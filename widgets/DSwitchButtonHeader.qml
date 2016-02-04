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

Rectangle {
    id: header

    property alias text: titleArea.text
    property alias style: titleArea.style
    property alias styleColor: titleArea.styleColor
    property alias active: actionArea.checked
    property alias font: titleArea.font

    property int leftMargin: DPalette.leftMargin
    property int rightMargin: DPalette.rightMargin

    height: 30
    width: parent.width
    color: DPalette.panelBgColor

    signal clicked

    DssH2 {
        id: titleArea
        anchors.left: parent.left
        anchors.leftMargin: leftMargin
        anchors.verticalCenter: parent.verticalCenter
    }

    Item {
        anchors.right: parent.right
        anchors.rightMargin: rightMargin
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 2
        width: actionArea.width

        DSwitchButton {
            id: actionArea
            anchors.centerIn: parent

            onClicked: {
                header.clicked()
            }
        }
    }
}
