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
    id: wrapper
    width: 100; height: DPalette.menuItemHeight

    property alias label: headLabel
    property alias value: headLabel.text
    property bool itemOnHover: false    //use wrapper.ListView.view.currentIndex to record index may cause crash,like deepin-movie font-list
    property int index: 0

    Rectangle {
        color: itemOnHover ? DPalette.popupMenuObj.hoverBgColor : DPalette.popupMenuObj.normalBgColor
        anchors.fill: parent
    }

    Image {
        id: headImg
        source: itemOnHover ? DPalette.imagesPath + "tick_hover.png" : DPalette.imagesPath + "tick_normal.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: DPalette.textLeftMargin
        visible: index == 0
    }

    DssH2 {
        id: headLabel
        anchors.left: parent.left
        anchors.leftMargin: DPalette.textLeftMargin * 2 + headImg.width
        anchors.verticalCenter: parent.verticalCenter
        text: "text " + index
        color: itemOnHover ? DPalette.popupMenuObj.hoverTextColor : DPalette.popupMenuObj.normalTextColor
    }
}

