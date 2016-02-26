/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

Rectangle {
    id: root

    property int frameRadius: radius
    property int shadowRadius: 10
    property real shadowAlpha: 0.5

    color: "transparent"
    default property alias content: rootFrame.children

    RectangularGlow {
        id: effect
        anchors.fill: rootFrame
        glowRadius: shadowRadius
        spread: 0.2
        color: Qt.rgba(0, 0, 0, shadowAlpha)
        cornerRadius: frameRadius + glowRadius
    }

    Rectangle{
        id: rootFrame
        width: parent.width - (frameRadius + shadowRadius) * 2
        height: parent.height - (frameRadius + shadowRadius) * 2
        anchors.centerIn: parent
        radius: frameRadius

        color: Qt.rgba(0, 0, 0, 0.85)
        border.color: Qt.rgba(1, 1, 1, 0.2)
        border.width: 1
    }
}
