/****************************************************************************
**
**  Copyright (C) 2011~2014 Deepin, Inc.
**                2011~2014 Kaisheng Ye
**
**  Author:     Kaisheng Ye <kaisheng.ye@gmail.com>
**  Maintainer: Kaisheng Ye <kaisheng.ye@gmail.com>
**
**  This program is free software: you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation, either version 3 of the License, or
**  any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

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

