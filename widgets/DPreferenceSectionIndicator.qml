import QtQuick 2.1

Canvas {
	id: canvas
	width: 20
	height: 300
	antialiasing: true

	property int pointerPos: Math.floor(height / 2)
	property int pointerHeight: 10
	property int pointerWidth: 20

	onWidthChanged: requestPaint()        
	onHeightChanged: requestPaint()
	onPointerPosChanged: requestPaint()

	onPaint: {
		var ctx = getContext("2d")

		ctx.clearRect(0, 0, canvas.width, canvas.height)

		ctx.beginPath()
		ctx.moveTo(width - 1, 0)
		ctx.lineTo(width - 1, pointerPos - pointerWidth / 2)
		ctx.lineTo(width - 1 - pointerHeight, pointerPos)
		ctx.lineTo(width - 1, pointerPos + pointerWidth / 2)
		ctx.lineTo(width - 1, height)
		ctx.lineWidth = 1
		ctx.strokeStyle = "black"
		ctx.stroke()
		ctx.closePath()

		ctx.beginPath()
		ctx.moveTo(width - 2, 0)
		ctx.lineTo(width - 2, pointerPos - pointerWidth / 2)
		ctx.lineTo(width - 2 - pointerHeight, pointerPos)
		ctx.lineTo(width - 2, pointerPos + pointerWidth / 2)
		ctx.lineTo(width - 2, height)
		ctx.lineWidth = 1
		ctx.strokeStyle = "white"
		ctx.stroke()
		ctx.closePath()
	}
}