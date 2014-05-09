import QtQuick 2.0

DTextInput {
    id: fileChooseInput

    signal fileChooseClicked

    textInput.anchors.rightMargin: 3 + buttonBox.width
    Rectangle {
        id: buttonBox
        parent: textInputBox
        width: childrenRect.width
        height: parent.height
        anchors.right: parent.right
        color: constants.bgColor
        z: 10

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        DOpacityImageButton {
            id: increaseButton
            anchors.verticalCenter: parent.verticalCenter
            source: "images/file_choose.png"
            onClicked: fileChooseInput.fileChooseClicked()
        }
    }
}
