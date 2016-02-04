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

DImageButton {
    readonly property string directionLeft: "left"
    readonly property string directionRight: "right"
    readonly property string directionUp: "up"
    readonly property string directionDown: "down"

    property string direction: "right"

    transitionEnabled: true

    normal_image: DPalette.imagesPath + "arrow_" + direction +"_normal.png"
    hover_image: DPalette.imagesPath + "arrow_" + direction +"_hover.png"
    press_image: DPalette.imagesPath + "arrow_" + direction + "_press.png"
}
