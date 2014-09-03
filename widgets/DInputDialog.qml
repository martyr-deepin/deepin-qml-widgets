import QtQuick 2.1
import Deepin.Widgets 1.0

DDialog {
    id: dialog
    width: 364
    height: 140

    property alias message: msg.text
    property alias confirmButtonLabel: confirm_button.text
    property alias cancelButtonLabel: cancel_button.text

    signal confirmed (string input)
    signal cancelled

    Column {
        spacing: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 25
        anchors.rightMargin: 25

        Text {
            id: msg
            text: "hello world"
            color: "white"
        }
        DTextInput { id: input; width: 300 }
        Row {
            spacing: 10
            anchors.right: parent.right

            DTextButton {
                id: confirm_button
                text: "Confirm"

                onClicked: { dialog.confirmed(input.text); input.text = ""; dialog.close(); }
            }
            DTextButton {
                id: cancel_button
                text: "Cancel"

                onClicked: { dialog.cancelled(); input.text = ""; dialog.close(); }
            }
        }
    }
}