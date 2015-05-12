import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

DBaseLine {
    id: header

    property string text: "untitled"

    signal toggled

    DConstants {id: dconstants}

    leftLoader.sourceComponent: Label {
        id: titleLabel
        text: header.text
        color: dconstants.textNormalColor
    }

    rightLoader.sourceComponent: Image {
        id: arrow
        source: dconstants.imagesPath + "arrow_right_normal.png"
        MouseArea {
            anchors.fill:parent
            onClicked: {
                toggled()
            }
        }
    }
}
