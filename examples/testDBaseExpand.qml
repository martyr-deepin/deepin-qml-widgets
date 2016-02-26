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
    width: 200
    height: 400
    color: "yellow"

    DBaseExpand {
        id:testExpand
        width: parent.width * 4 / 5
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        header.sourceComponent: DArrowButton {
            direction:directionDown
            onClicked:{
                if (direction == directionDown){
                    direction = directionUp
                    testExpand.expanded = true
                }
                else{
                    direction = directionDown
                    testExpand.expanded = false
                }
            }
        }
        content.sourceComponent: Text {
            height: 200
            width: testExpand.width
            text: "Test text..."
            font.pixelSize: 15
        }
    }
}
