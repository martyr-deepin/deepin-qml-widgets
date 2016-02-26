/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.2
import QtQuick.Controls 1.1
import Deepin.Widgets 1.0

GroupBox {
    id: g_box
    title: " "
    property string tTitle: ""
    
    DssH2 {
        text: g_box.tTitle
        parent: g_box
    }
}