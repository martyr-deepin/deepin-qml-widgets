import QtQuick 2.1
import Deepin.Widgets 1.0

Row {
    width: leftRec.width + rightRec.width
    height: parent.height

    property color leftColor: DConstants.separatorStyle.leftColor
    property color rightColor: DConstants.separatorStyle.rightColor

    Rectangle {
        id: leftRec
        width: DConstants.separatorStyle.leftWidth
        height: parent.height
        color: leftColor
    }
    Rectangle {
        id:rightRec
        width: DConstants.separatorStyle.rightWidth
        height: parent.height
        color: rightColor
    }
}
