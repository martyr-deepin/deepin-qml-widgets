/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import Deepin.Widgets 1.0

CheckBox {
    property int fontSize: 12
    property url imageSource
    property int spacing: 2

    text: "hello"
    style: CheckBoxStyle {
        spacing: control.spacing
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? DPalette.imagesPath + "checkbox_checked_hover.png" : DPalette.imagesPath + "checkbox_checked.png"
                                    : control.hovered ? DPalette.imagesPath + "checkbox_unchecked_hover.png" : DPalette.imagesPath + "checkbox_unchecked.png"
        }
        label: Image {
            source: control.imageSource
        }
    }
}
