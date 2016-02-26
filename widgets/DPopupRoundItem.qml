/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1
import QtGraphicalEffects 1.0

Item {
	id: container
	property variant target
	width: target.width; height: target.height
	property alias radius: mask.radius
	
	Rectangle {
		anchors.fill: container
		id: mask
		radius: container.radius
		antialiasing: true
		smooth: true
	}
	
    OpacityMask {
		anchors.fill: parent
        source: ShaderEffectSource { sourceItem: target; hideSource: true }
        maskSource: ShaderEffectSource{ sourceItem: mask; hideSource: true }
    }
}
	
