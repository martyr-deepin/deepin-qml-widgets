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

Rectangle{
    id: textButton
    width: buttonHeader.width + buttonMiddle.width + buttonTail.width
    height: buttonHeader.height
    color: "transparent"
    property int minMiddleWidth: 50

    property alias text: title.text
    property alias textColor: title.color
    signal clicked

    QtObject { //enumeration for button image
        id: buttonImage
        property string headerNormal: DPalette.imagesPath + "button_left_normal.png"
        property string headerPress: DPalette.imagesPath + "button_left_press.png"
        property string middleNormal: DPalette.imagesPath + "button_center_normal.png"
        property string middlePress: DPalette.imagesPath + "button_center_press.png"
        property string tailNormal: DPalette.imagesPath + "button_right_normal.png"
        property string tailPress: DPalette.imagesPath + "button_right_press.png"
    }

    Row {
        anchors.top: parent.top
        anchors.left: parent.left

        Image{
            id: buttonHeader
            source: buttonImage.headerNormal
        }

        Image {
            id: buttonMiddle
            source: buttonImage.middleNormal
            width: title.width + 8 < minMiddleWidth ? minMiddleWidth : title.width + 8

            Text{
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: DPalette.textNormalColor
                font.pixelSize: 12
            }

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                width: parent.width
                height: parent.height
                onPressed: {
                    buttonHeader.source = buttonImage.headerPress
                    buttonMiddle.source = buttonImage.middlePress
                    buttonTail.source = buttonImage.tailPress
                }
                onReleased: {
                    buttonHeader.source = buttonImage.headerNormal
                    buttonMiddle.source = buttonImage.middleNormal
                    buttonTail.source = buttonImage.tailNormal
                }
                onClicked: {
                    textButton.clicked()
                }
            }
        }

        Image{
            id: buttonTail
            source: buttonImage.tailNormal
        }
    }
}
