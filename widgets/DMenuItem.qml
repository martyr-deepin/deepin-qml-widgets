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
    width: wrapper.ListView.view.width; height: 26

    signal selectAction(int index)

    property alias text: label.text
    property bool itemOnHover: false    //use wrapper.ListView.view.currentIndex to record index may cause crash,like deepin-movie font-list

    Rectangle {
        color: itemOnHover ? "#141414" : "#232323"
        anchors.fill: parent
    }

    DssH2 {
        id: label
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        text: "text " + index
        color: itemOnHover ? dconstants.activeColor : dconstants.fgColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered:{
            itemOnHover = true
        }
        onExited: {
            itemOnHover = false
        }
        onClicked: selectAction(index)
    }
}

