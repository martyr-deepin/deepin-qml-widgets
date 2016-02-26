/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import Deepin.Widgets 1.0

DTextInput {
    id: fileChooseInput

    signal fileChooseClicked

    textInput.anchors.rightMargin: 3 + buttonBox.width
    Item {
        id: buttonBox
        parent: textInputBox
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
                    color: loadFileButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                }
                GradientStop {
                    position: 1.0
                    color: loadFileButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                }
            }
        }

        DImageButton {
            id: loadFileButton
            anchors.verticalCenter: parent.verticalCenter
            normal_image: DPalette.imagesPath + "loadfile_normal.png"
            hover_image: DPalette.imagesPath + "loadfile_hover.png"
            press_image: DPalette.imagesPath + "loadfile_press.png"
            onClicked: fileChooseInput.fileChooseClicked()
        }
    }
}
