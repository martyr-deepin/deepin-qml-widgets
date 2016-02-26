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
    width: 400
    height: 200

	property var testList: DConstants.styleList
	onTestListChanged: {
		print ("============",testList)
	}

    DConstants { id: DConstants }

    Row {
        width: parent.width
        height: parent.height / 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 30

        Rectangle {
            color: DConstants.activeColor
            width: 100
            height: 20
            border.width: 0
            border.color: DConstants.tuhaoColor
            Text {
                id:whiteText
                text: "White Style"
                color: "#ffffff"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    print ("Change to white style...")
                    DUIStyle.setCurrentWidgetStyle("StyleWhite")
                }
                onEntered: parent.border.width = 2
                onExited: parent.border.width = 0
            }
        }

        Rectangle {
            color: DConstants.activeColor
            width: 100
            height: 20
            border.width: 0
            border.color: DConstants.tuhaoColor
            Text {
                text: "Black Style"
                color: "#ffffff"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    print ("Change to black style...")
                    DUIStyle.setCurrentWidgetStyle("StyleBlack")
                }
                onEntered: parent.border.width = 2
                onExited: parent.border.width = 0
            }
        }
    }
}
