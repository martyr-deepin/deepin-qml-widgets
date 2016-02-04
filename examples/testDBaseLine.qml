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
    width: 500
    height: 500
    color: "yellow"

    DBaseLine {
        anchors.centerIn: parent
        leftLoader.sourceComponent: Rectangle {
            height: contentText.contentHeight
            width: contentText.contentWidth
            color: "red"
            Text {
                id:contentText
                text: "Left content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        rightLoader.sourceComponent: Rectangle {
            height: contentText2.contentHeight
            width: contentText2.contentWidth
            color: "red"
            Text {
                id:contentText2
                text: "Right content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}

