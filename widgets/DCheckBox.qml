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
    property string imagesPath: DPalette.imagesPath

    text: "hello"
    style: CheckBoxStyle {
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? imagesPath + "checkbox_checked_hover.png" : imagesPath + "checkbox_checked.png"
                                    : control.hovered ? imagesPath + "checkbox_unchecked_hover.png" : imagesPath + "checkbox_unchecked.png"
        }
        label: Text {
            color: DPalette.textNormalColor
            text: control.text
            font.pixelSize: control.fontSize
        }
    }
}
