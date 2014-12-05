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
