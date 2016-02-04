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

Rectangle {
    id: header

    property alias leftLoader: leftArea
    property alias rightLoader: rightArea
    property int leftMargin: 15
    property int rightMargin: 15

    height: 30
    width: parent.width
    color: DPalette.panelBgColor

    Loader {
        id: leftArea
        anchors.left: parent.left
        anchors.leftMargin: leftMargin
        anchors.verticalCenter: parent.verticalCenter
    }

    Loader {
        id: rightArea
        anchors.right: parent.right
        anchors.rightMargin: rightMargin
        anchors.verticalCenter: parent.verticalCenter
    }
}
