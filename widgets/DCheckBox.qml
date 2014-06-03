import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

CheckBox {
    text: "hello"
    style: CheckBoxStyle {
        background: Item {}
        indicator: Rectangle {
            radius: 3
            width: 14
            height: 14
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.5)

            Rectangle {
                width: 8
                height: 8
                radius: 2
                color: Qt.rgba(1, 1, 1, 0.5)
                visible: control.checked

                anchors.centerIn: parent
            }
        }
        label: Text {
            color: Qt.rgba(1, 1, 1, 0.5)
            text: control.text
        }        
    }
}