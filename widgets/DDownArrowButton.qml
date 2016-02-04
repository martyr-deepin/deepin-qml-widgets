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

Item {
    id: arrowButton
    anchors.centerIn: parent
    width: image.width
    height: image.height

    property bool checked: false
    state: checked ? "up" : "down"

    signal clicked

    property string imageKey: "down"

    DOpacityImageButton {
        id: image
        anchors.centerIn: parent
        source: DPalette.imagesPath + "arrow_" + imageKey + "_white.png"

        onClicked: {
            arrowButton.checked = !arrowButton.checked
            arrowButton.clicked()
        }

    }

    states:  [
        State {
            name: "down"
            PropertyChanges { target: arrowButton; imageKey: "down" }
        },
        State {
            name: "up"
            PropertyChanges { target: arrowButton; imageKey: "up" }
        }
    ]
}
