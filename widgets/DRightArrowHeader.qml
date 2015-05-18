import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Deepin.Widgets 1.0

DBaseLine {
    id: header

    property string text: "untitled"

    signal toggled

    leftLoader.sourceComponent: Label {
        id: titleLabel
        text: header.text
        color: DConstants.textNormalColor
    }

    rightLoader.sourceComponent: Image {
        id: arrow
        source: DConstants.imagesPath + "arrow_right_normal.png"
        MouseArea {
            anchors.fill:parent
            onClicked: {
                toggled()
            }
        }
    }
}
