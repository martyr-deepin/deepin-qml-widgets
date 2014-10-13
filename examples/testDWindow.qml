import QtQuick 2.0
import Deepin.Widgets 1.0

DWindow {
    color :Qt.rgba(1.0, 0.5, 0, 0.2)
    Text {
	text : "dwindow"
    }
    width:300
    height:300
    Component.onCompleted: print(getWinId())
}
