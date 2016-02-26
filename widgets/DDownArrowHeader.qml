/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Deepin.Widgets 1.0

Rectangle {
    id: header

    property string text: "Untitled"
    property string hintText: ""
    property int hintTextSize: 12
    property alias icon: iconImage.source
    property alias active: actionButton.checked

    property int leftMargin: DPalette.leftMargin
    property int rightMargin: DPalette.rightMargin
    focus: true

    height: 30
    width: parent.width
    color: DPalette.panelBgColor

    signal clicked

    Item {
        anchors.fill: parent
        anchors.left: parent.left
        anchors.leftMargin: leftMargin
        anchors.right: parent.right
        anchors.rightMargin: rightMargin

        Row {
            height: parent.height
            width: parent.width - actionArea.width
            spacing: 2

            Item {
                id: iconArea
                width: iconImage.width + 8
                height: iconImage.height
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    id: iconImage
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    visible: source ? true : false
                }
            }

            DssH2 {
                id: titleArea
                text: header.text
                anchors.verticalCenter: parent.verticalCenter
            }

            DssH2 {
                id: darkArea
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: header.hintTextSize
                color: DPalette.itemTipColor
                visible: text != "" ? true : false
                text: header.hintText
            }
            Component.onCompleted: {
                darkArea.width = width - iconArea.width - titleArea.width
            }

        }

        Item {
            id: actionArea
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 2
            width: actionButton.width

            DArrowButton {
                id: actionButton
                direction: checked ? directionUp : directionDown
                anchors.centerIn: parent

                property bool checked: false
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            actionButton.checked = !actionButton.checked
            header.clicked()
        }
    }
}
