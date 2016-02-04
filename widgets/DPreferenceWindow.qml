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
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

DWindow {
	id: root
	width: 300
	height: 300
	color: "transparent"
	flags: Qt.FramelessWindowHint | Qt.SubWindow
    shadowWidth: 8

    property int titleContentPadding: 5
    property int bottomContentPadding: 10
    property int leftRightMargin: 10
    property alias title: titlebar_title.text
    default property alias content: loader.children

    // below three properties are deprecated, it's here only for compat purpose.
    property string currentSectionId
    property bool showActionButton
    property string actionButtonText

    signal action()

	RectangularGlow {
	    id: shadow
	    anchors.fill: rect
	    glowRadius: root.shadowWidth - 5
	    spread: 0
	    color: Qt.rgba(0, 0, 0, 1)
	    cornerRadius: 10
	    visible: true
	}

	Rectangle {
		id: rect
		clip: true
		radius: 4
		color: DPalette.contentBgColor
		width: root.width - root.shadowWidth * 2
		height: root.height - root.shadowWidth * 2
        border.width: 1
        border.color: "black"
		anchors.centerIn: parent

        Rectangle {
            width: parent.width - 2
            height: parent.height - 2
            anchors.centerIn: parent
            color: "transparent"
            radius: 3
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.1)
        }

		DDragableArea {
			id: titlebar
            z: loader.z + 1
			width: rect.width
			height: close_button.height
            window: root

            Text {
                id: titlebar_title
                color: "white"
                font.pixelSize: 10
                width: Math.min(parent.width - 40, implicitWidth)
                anchors.verticalCenter: close_button.verticalCenter
                anchors.horizontalCenter: titlebar.horizontalCenter
            }

			DImageButton {
			    id: close_button
			    normal_image: DPalette.imagesPath + "window_close_normal.png"
                hover_image: DPalette.imagesPath + "window_close_hover.png"
                press_image: DPalette.imagesPath + "window_close_press.png"
			    anchors.top: parent.top
			    anchors.right: parent.right

			    onClicked: { root.close() }
			}
		}

        Item {
            id: loader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titlebar.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: root.leftRightMargin
            anchors.rightMargin: root.leftRightMargin
            anchors.topMargin: root.titleContentPadding
            anchors.bottomMargin: root.bottomContentPadding
        }
	}
 }
