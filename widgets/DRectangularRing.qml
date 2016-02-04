/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.1

Canvas {
    id: canvas
    width: outterWidth
    height: outterHeight
    antialiasing: true
    renderStrategy: Canvas.Threaded
    renderTarget: Canvas.Image
    property int outterRadius: 0
    property int outterWidth: 100
    property int outterHeight: 100
    property int innerRadius: 0
    property int innerWidth: 50
    property int innerHeight: 50
    property int horizontalCenterOffset: 0
    property int verticalCenterOffset: 0
    property color color: Qt.rgba(0, 0, 0, 1)

    onOutterWidthChanged: requestPaint()
    onOutterHeightChanged: requestPaint()
    onInnerWidthChanged: requestPaint()
    onInnerHeightChanged: requestPaint()
    onColorChanged: requestPaint()
    onOutterRadiusChanged: requestPaint()
    onInnerRadiusChanged: requestPaint()
    onHorizontalCenterOffsetChanged: requestPaint()
    onVerticalCenterOffsetChanged: requestPaint()

    onPaint: {
        var ctx = canvas.getContext('2d');
        ctx.save();
        ctx.clearRect(0, 0, canvas.outterWidth, canvas.outterHeight);
        ctx.globalAlpha = canvas.alpha;

        ctx.beginPath()
        ctx.fillStyle = canvas.color
        ctx.roundedRect(0, 0, canvas.outterWidth, canvas.outterHeight,
                        canvas.outterRadius, canvas.outterRadius)
        ctx.closePath()
        ctx.fill()

        ctx.globalCompositeOperation = "destination-out"
        ctx.fillStyle = "#000000"
        ctx.beginPath()
        ctx.roundedRect((canvas.outterWidth - canvas.innerWidth) / 2 + horizontalCenterOffset,
                        (canvas.outterHeight - canvas.innerHeight) / 2 + verticalCenterOffset,
                        canvas.innerWidth, canvas.innerHeight,
                        canvas.innerRadius, canvas.innerRadius)
        ctx.closePath()
        ctx.fill()

        ctx.restore();
    }
}
