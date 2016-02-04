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

DWindow {
    id: rootWindow
	width: 800
	height: 500
	color: "transparent"
    flags: Qt.FramelessWindowHint

	DWindowFrame {
		anchors.fill: parent

        Item {
            id: titleArea
            width: parent.width
            height: 40

            DDragableArea{
                anchors.fill: parent
                window: rootWindow
            }

            Row {
                anchors.right: parent.right
                DTitleOptionButton{}
                DTitleMinimizeButton{}
                DTitleMaxUnmaxButton{}
                DTitleCloseButton{
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }

        Column {
            width: parent.width - 10
            anchors.top: titleArea.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5

            DArrowButton{}
            DCheckBox{
                text: "CheckBox"
            }
            DRadio{
                text: "Radio"
            }
        }
	}
}
