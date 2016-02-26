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

RadioButton {
    property int fontSize: 12
    property string imagesPath: DPalette.imagesPath

    style: RadioButtonStyle {
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? imagesPath + "radio_selected_hover.png" : imagesPath + "radio_selected.png"
                                    : control.hovered ? imagesPath + "radio_unselected_hover.png" : imagesPath + "radio_unselected.png"
        }
        label: Text {
            color: DPalette.textNormalColor
            text: control.text
            font.pixelSize: control.fontSize
        }
    }
}
