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

    DCenterLine {
        anchors.centerIn: parent
        title.text: "Title"
        title.verticalAlignment: Text.AlignVCenter
        content.sourceComponent: Rectangle {
            height: contentText.contentHeight
            width: contentText.contentWidth
            color: "red"
            Text {
                id:contentText
                text: "the content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
