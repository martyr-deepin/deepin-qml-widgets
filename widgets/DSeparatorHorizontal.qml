import QtQuick 2.1
import Deepin.Widgets 1.0

Item {
    width: parent.width
    height: topRec.height + bottomRec.height

    DConstants{id:dconstants}

    property color topColor: dconstants.separatorStyle.topColor
    property color bottomColor: dconstants.separatorStyle.bottomColor

    Rectangle {
        id: topRec
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: dconstants.separatorStyle.topHeight
        color: topColor
    }
    Rectangle {
        id: bottomRec
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        width: parent.width
        height: dconstants.separatorStyle.bottomHeight
        color: bottomColor
    }
}
