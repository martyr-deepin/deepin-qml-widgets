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

DSingleLineTip {
    width: 100
    height: 40
    radius:2
    textColor:"#000000"
    backgroundColor:"#ffffff"
	arrowWidth: 6
    arrowHeight: 9
	arrowLeftMargin: 20
    destroyInterval: 200
	borderColor: "#000fff"
    fontPixelSize: 8
	x:100
    y:500

    property alias animationEnable: yAnimation.enabled

    Behavior on y {
        id:yAnimation
        SmoothedAnimation {duration:  300}
    }
}

