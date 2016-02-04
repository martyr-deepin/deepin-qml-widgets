/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1
import QtGraphicalEffects 1.0

Rectangle {
    radius: 3
    border.color: Qt.rgba(0, 0, 0, 1)
    border.width: 1

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#1e1e1e"}
        GradientStop { position: 0.8; color: "#080808"}
        GradientStop { position: 0.95; color: "#0e0e0e"}
        GradientStop { position: 1.0; color: "#2b2b2b"}
    }

    Rectangle {
        id: white_stroke
        width: parent.width - 2
        height: parent.height - 2
        border.color: Qt.rgba(1, 1, 1, 0.1)
        border.width: 1
        color: "transparent"

        anchors.centerIn: parent
    }
}
