import QtQuick 2.1
import Deepin.Widgets 1.0

Item {
    width: parent.width
    height: topRec.height + bottomRec.height

    property color topColor: DPalette.separatorStyle.topColor
    property color bottomColor: DPalette.separatorStyle.bottomColor

    Rectangle {
        id: topRec
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: DPalette.separatorStyle.topHeight
        color: topColor
    }
    Rectangle {
        id: bottomRec
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        width: parent.width
        height: DPalette.separatorStyle.bottomHeight
        color: bottomColor
    }
}
