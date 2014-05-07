import QtQuick 2.1
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0

Window {
	id: window
	width: 300
	height: 300
	color: "transparent"
	flags: Qt.FramelessWindowHint | Qt.Popup

	property int windowGlowRadius: 8

	DConstants { id: dconstants }

	RectangularGlow {
	    id: shadow
	    anchors.fill: rect
	    glowRadius: window.windowGlowRadius - 5
	    spread: 0
	    color: Qt.rgba(0, 0, 0, 1)
	    cornerRadius: 10
	    visible: true
	}

	Rectangle {
		id: rect
		clip: true
		radius: 3
		color: dconstants.bgColor
		width: window.width - window.windowGlowRadius * 2
		height: window.height - window.windowGlowRadius * 2
		anchors.centerIn: parent

		Item {
			id: titlebar
			width: rect.width
			height: close_button.height

			MouseArea {
				anchors.fill: titlebar
				property int startX
				property int startY

				onPressed: {
					startX = mouse.x
					startY = mouse.y
				}

				onPositionChanged: {
					if (pressed) {
						window.setX(window.x + mouse.x - startX)
						window.setY(window.y + mouse.y - startY)
					}
				}
			}

			DImageButton {
			    id: close_button
			    normal_image: "images/window_close_normal.png"
                hover_image: "images/window_close_hover.png"
                press_image: "images/window_close_press.png"
			    anchors.top: parent.top
			    anchors.right: parent.right

			    onClicked: { window.close() }
			}
		}
	}
}