import QtQuick 2.1
import Deepin.Widgets 1.0

Item {
	width: 300
	height: 300

	Timer {
		running: true
		repeat: true
		interval: 3000
		onTriggered: { print("triggered"); btn.enabled = !btn.enabled }
	}

	DSwitchButton {
		id: btn
		anchors.centerIn: parent
	}
}