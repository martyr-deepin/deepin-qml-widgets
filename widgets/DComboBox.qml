import QtQuick 2.1
import QtQuick.Window 2.1

Item {
    width: background.width
    height: background.height

    property bool hovered: false
    property bool pressed: false

    property alias text: currentLabel.text

    QtObject {
        id: buttonImage
        property string status: "normal"
        property string header: "images/button_left_%1.png".arg(status)
        property string middle: "images/button_center_%1.png".arg(status)
        property string tail: "images/button_right_%1.png".arg(status)
    }

    property int minMiddleWidth: 48

    Window {
        id: menu
        flags: Qt.WindowSystemMenuHint
        width: background.width
        height: childrenRect.height

        Rectangle{
            width: parent.width
            height: childrenRect.height

            ListView {
                width: parent.width
                height: childrenRect.height

                model: 5
                delegate: DssH2 {
                    text: "test " + index
                } 

            }
        }
    }

    Row {
        id: background
        height: buttonHeader.height

        Image{
            id: buttonHeader
            source: buttonImage.header
        }

        Image {
            id: buttonMiddle
            source: buttonImage.middle
            width: content.width < minMiddleWidth ? minMiddleWidth : content.width
        }

        Image{
            id: buttonTail
            source: buttonImage.tail
        }
    }

    Row {
        id: content
        height: background.height
        anchors.centerIn: parent
        spacing: 6

        DssH2{
            id: currentLabel
            anchors.verticalCenter: parent.verticalCenter
        }

        Image {
            anchors.verticalCenter: parent.verticalCenter

            source: hovered ? "images/arrow_down_hover.png" : "images/arrow_down_normal.png"
        }

    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            hovered = true
        }

        onExited: {
            hovered = false
        }

        onClicked: {
            menu.show()
        }
    }

}
