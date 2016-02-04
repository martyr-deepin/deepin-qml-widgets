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
    property int minMiddleWidth: 48

    property alias text: title.text
    property alias textColor: title.color

    signal clicked

    QtObject {
        id: buttonImage
        property string stateString: "normal"

        property string headerImg: DPalette.imagesPath + "transparent_button_left_%1.png".arg(stateString)
        property string middleImg: DPalette.imagesPath + "transparent_button_middle_%1.png".arg(stateString)
        property string tailImg: DPalette.imagesPath + "transparent_button_right_%1.png".arg(stateString)
    }

    states: [
        State {
            name: "hovered"
            PropertyChanges { target: buttonImage; stateString: "hover"}
        },
        State {
            name: "pressed"
            PropertyChanges { target: buttonImage; stateString: "press"}
        }
    ]

    Row {
        anchors.top: parent.top
        anchors.left: parent.left

        Image{
            id: buttonHeader
            source: buttonImage.headerImg
        }

        Image {
            id: buttonMiddle
            source: buttonImage.middleImg
            width: title.width + 8 < minMiddleWidth ? minMiddleWidth : title.width + 8

            Text {
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "#b4b4b4"
                font.pixelSize: 12
                text: "test"
            }

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                width: parent.width
                height: parent.height
                onEntered: {
                    textButton.state = "hovered"
                }
                onExited: {
                    textButton.state = ""
                }
                onPressed: {
                    textButton.state = "pressed"
                }
                onReleased: {
                    if(containsMouse){
                        textButton.state = "hovered"
                    }
                    else{
                        textButton.state = ""
                    }
                }

                onClicked: {
                    textButton.clicked()
                }
            }

        }

        Image{
            id: buttonTail
            source: buttonImage.tailImg
        }


    }
}
