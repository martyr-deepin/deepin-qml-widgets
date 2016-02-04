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
    id: editComboBox
    textInput.anchors.rightMargin: 3 + buttonBox.width

    signal showRequested(int x, int y, int width, int height)

    function showMenu(){
        var pos = mapToItem(null, 0, 0)
        var x = pos.x
        var y = pos.y + height
        var w = width
        var h = height
        showRequested(x, y, w, h)
    }

    Item {
        id: buttonBox
        width: childrenRect.width
        height: parent.height
        anchors.right: parent.right
        z: 10

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        Rectangle {
            width: parent.width - 1
            height: parent.height
            anchors.right: parent.right
            radius: 3
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: dropDownButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                }
                GradientStop {
                    position: 1.0
                    color: dropDownButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                }
            }
        }

        Item {
            width: 24
            height: parent.height
            DImageButton {
                id: dropDownButton
                anchors.centerIn: parent
                normal_image: DPalette.imagesPath + "arrow_down_normal.png"
                hover_image: DPalette.imagesPath + "arrow_down_hover.png"
                press_image: DPalette.imagesPath + "arrow_down_press.png"
                onClicked: editComboBox.showMenu()
            }
        }
    }
}
