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

    property alias title: title
    property alias content: rightArea
    property int leftWidth: 120
    property int centerPadding: 10

    height: 30
    width: parent.width
    color: DPalette.panelBgColor

    DLabel {
        id: title
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
        width: leftWidth
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignRight
        text: "Double click frequency"
    }

    Loader {
        id: rightArea
        anchors.left: title.right
        anchors.leftMargin: centerPadding
        anchors.verticalCenter: parent.verticalCenter
    }
}
