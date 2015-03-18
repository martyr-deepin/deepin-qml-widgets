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
import QtQuick.Window 2.1

DPopupWindow {
    id: menuPopupWindow
    property int frameEdge: menuFrame.shadowRadius + menuFrame.frameRadius
    property int minWidth: 30
    property real posX: 0
    property real posY: 0

    x: posX - 28
    y: posY - 12

    width: minWidth + 24
    height: completeViewBox.height + 32

    property int maxHeight: -1

    property alias currentIndex: completeView.currentIndex
    property var currentTextValue
    property var labels
    property var sortLabels
    visible: false

    signal menuSelect(int index)

    function showMenu(){
        sortLabels = getSortLabels()
        menuPopupWindow.visible = true
    }

    function getSortLabels(){
        //move combobox's current value to the top
        //array.unshift() not work well here,so use reverse and reverse back
        var tmpLabels = labels.slice()//copy array data
        tmpLabels.splice(tmpLabels.indexOf(currentTextValue), 1)
        tmpLabels.reverse()
        tmpLabels.push(currentTextValue)
        tmpLabels.reverse()

        return tmpLabels
    }


    DWindowFrame {
        id: menuFrame
        anchors.fill: parent
        frame.color: "#191919"
        frame.border.width: 1
        frame.border.color: "#101010"

        Item {
            id: completeViewBox
            anchors.centerIn: parent
            width: parent.width - 6
            height: childrenRect.height

            ListView {
                id: completeView
                width: parent.width
                height: maxHeight != -1 ? Math.min(childrenHeight, maxHeight) : childrenHeight
                property int childrenHeight: childrenRect.height
                maximumFlickVelocity: 1000
                model: sortLabels
                delegate: DMenuItem {
                    text: sortLabels[index]
                    onSelectAction:{
                        menuPopupWindow.visible = false
                        menuPopupWindow.menuSelect(labels.indexOf(sortLabels[index]))
                    }
                }
                clip: true
            }
        }

    }

}
