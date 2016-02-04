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

Row {
    width: leftRec.width + rightRec.width
    height: parent.height

    property color leftColor: DPalette.separatorStyle.leftColor
    property color rightColor: DPalette.separatorStyle.rightColor

    Rectangle {
        id: leftRec
        width: DPalette.separatorStyle.leftWidth
        height: parent.height
        color: leftColor
    }
    Rectangle {
        id:rightRec
        width: DPalette.separatorStyle.rightWidth
        height: parent.height
        color: rightColor
    }
}
