import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    id: header

    property alias text: titleArea.text
    property alias style: titleArea.style
    property alias styleColor: titleArea.styleColor
    property alias active: actionArea.checked
    property alias font: titleArea.font

    property int leftMargin: DConstants.leftMargin
    property int rightMargin: DConstants.rightMargin

    height: 30
    width: parent.width
    color: DConstants.panelBgColor

    signal clicked

    DssH2 {
        id: titleArea
        anchors.left: parent.left
        anchors.leftMargin: leftMargin
        anchors.verticalCenter: parent.verticalCenter
    }

    Item {
        anchors.right: parent.right
        anchors.rightMargin: rightMargin
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 2
        width: actionArea.width

        DSwitchButton {
            id: actionArea
            anchors.centerIn: parent

            onClicked: {
                header.clicked()
            }
        }
    }
}
