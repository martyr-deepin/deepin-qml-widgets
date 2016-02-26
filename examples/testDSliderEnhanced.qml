/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.0
import Deepin.Widgets 1.0

Rectangle{
    width: childrenRect.width
    height: childrenRect.height
    color: Qt.rgba(0, 0, 0, 0.7)
    DSliderEnhanced{
		min:-100
		max:1000
	}
}
