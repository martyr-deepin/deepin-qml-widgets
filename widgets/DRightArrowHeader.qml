/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Deepin.Widgets 1.0

DBaseLine {
    id: header

    property string text: "untitled"

    signal toggled

    leftLoader.sourceComponent: Label {
        id: titleLabel
        text: header.text
        color: DPalette.textNormalColor
    }

    rightLoader.sourceComponent: Image {
        id: arrow
        source: DPalette.imagesPath + "arrow_right_normal.png"
        MouseArea {
            anchors.fill:parent
            onClicked: {
                toggled()
            }
        }
    }
}
