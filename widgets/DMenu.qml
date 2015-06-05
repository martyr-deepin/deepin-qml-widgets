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
import Deepin.Widgets 1.0

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
    visible: false

    property int maxHeight: -1

    property int currentIndex: 0
    // labels property is deprecated, use model instead
    property var labels
    property alias model: menuPopupWindow.labels
    property Component delegate: Component {
        DMenuItem { width: menuPopupWindow.width; height: DConstants.menuItemHeight }
    }

    signal menuSelect(int index)

    function showMenu() {
        completeView.model = getSortedModel()
        menuPopupWindow.visible = true
    }

    function getSortedModel() {
        var temp = model.slice()
        var itemArray = temp.splice(currentIndex, 1)
        temp.splice(0, 0, itemArray[0])

        return temp
    }

    function getIndexBeforeSorted(index) {
        if (0 == index) {
            return currentIndex
        } else if (index <= currentIndex) {
            return index - 1
        } else {
            return index
        }
    }

    DWindowFrame {
        id: menuFrame
        anchors.fill: parent

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
                model: menuPopupWindow.model
                delegate: Item {
                    width: loader.width
                    height: loader.height

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:{
                            loader.item.itemOnHover = true
                        }
                        onExited: {
                            loader.item.itemOnHover = false
                        }
                        onClicked: {
                            menuPopupWindow.currentIndex = menuPopupWindow.getIndexBeforeSorted(index)
                            menuPopupWindow.visible = false
                            menuPopupWindow.menuSelect(menuPopupWindow.currentIndex)
                        }
                    }

                    Loader {
                        id: loader
                        sourceComponent: menuPopupWindow.delegate

                        onLoaded: {
                            item.width = Qt.binding(function() { return completeView.width })
                            item.index = index
                            item.value = completeView.model[index]
                        }
                    }
                }
                clip: true
            }
        }
    }
}
