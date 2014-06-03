import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

RadioButton {
    style: RadioButtonStyle {
        background: Item {}
        indicator: Rectangle {
            width: 14
            height: 14
            radius: 7
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.5)

            Rectangle {
                width: 8
                height: 8
                radius: 4
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