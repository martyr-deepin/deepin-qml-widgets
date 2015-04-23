import QtQuick 2.1
import Deepin.Widgets 1.0

Row {
    width: leftRec.width + rightRec.width
    height: parent.height

    DConstants{id:dconstants}

    property color leftColor: dconstants.separatorStyle.leftColor
    property color rightColor: dconstants.separatorStyle.rightColor

    Rectangle {
        id: leftRec
        width: dconstants.separatorStyle.leftWidth
        height: parent.height
        color: leftColor
    }
    Rectangle {
        id:rightRec
        width: dconstants.separatorStyle.rightWidth
        height: parent.height
        color: rightColor
    }
}
