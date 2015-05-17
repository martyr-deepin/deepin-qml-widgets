import QtQuick 2.0
import Deepin.Widgets 1.0

Rectangle {

	width: 500
	height: 300
	color: "gray"

	Column {
		spacing: 10
		anchors.centerIn: parent

		DSpinner {
			width:200
			min:-3
			initValue:3
		}
	}
}
