/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import Deepin.Widgets 1.0

DBaseLine {
    id: dssTitle
    width: parent.width
    height: DPalette.dssTitleStyle.height

    signal titleClicked
    property string text: ""

    leftLoader.sourceComponent: DssH1 {
        id: title
        font.weight: Font.DemiBold
        color: DPalette.dssTitleStyle.color
        text: dssTitle.text

        MouseArea {
            anchors.fill: parent
            onClicked: dssTitle.titleClicked()
        }
    }
}
