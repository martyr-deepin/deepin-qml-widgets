/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    property alias glowRadius: effect.glowRadius
    property alias spread: effect.spread
    property alias cached: effect.cached
    property alias color: effect.color
    property alias cornerRadius: effect.cornerRadius

    property int reservedRadius: effect.glowRadius * 2

    Component.onCompleted: {
        if (anchors.fill) {
            var _width = anchors.fill.width + reservedRadius * 2
            var _height = anchors.fill.height + reservedRadius * 2

            anchors.centerIn = anchors.fill
            anchors.fill = null
            width = _width
            height = _height
        }
    }

    DRectangularRing {
        id: rectangular_ring
        visible: false
        outterWidth: parent.width
        outterHeight: parent.height
        innerWidth: outterWidth - parent.reservedRadius * 2
        innerHeight: outterHeight - parent.reservedRadius * 2
        innerRadius: parent.cornerRadius - parent.glowRadius
    }

    Item {
        id: effect_rect
        visible: false

        Item {
            id: effect_center_rect_place_holder
            width: rectangular_ring.innerWidth
            height: rectangular_ring.innerHeight
            anchors.centerIn: parent
        }

        RectangularGlow {
            id: effect
            anchors.fill: effect_center_rect_place_holder
        }

        anchors.fill: rectangular_ring
    }

    OpacityMask {
        anchors.fill: rectangular_ring
        source: effect_rect
        maskSource: rectangular_ring
    }
}