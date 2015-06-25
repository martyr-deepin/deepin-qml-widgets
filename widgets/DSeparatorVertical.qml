import QtQuick 2.1
import Deepin.Widgets 1.0

Row {
    width: leftRec.width + rightRec.width
    height: parent.height

    property color leftColor: DPalette.separatorStyle.leftColor
    property color rightColor: DPalette.separatorStyle.rightColor

    Rectangle {
        id: leftRec
        width: DPalette.separatorStyle.leftWidth
        height: parent.height
        color: leftColor
    }
    Rectangle {
        id:rightRec
        width: DPalette.separatorStyle.rightWidth
        height: parent.height
        color: rightColor
    }
}
