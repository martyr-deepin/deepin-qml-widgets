
import QtQuick 2.1
import QtGraphicalEffects 1.0

FocusScope {
    id: root
    width: 160
    height: 22
    state: "normal"

    property alias echoMode: text_input.echoMode
    property alias text: text_input.text
    property int textInputRightMargin: 0
    property int textInputLeftMargin: 0
    property variant constants: DConstants {}
    property alias textInput: text_input
    property bool isPassword: false

    Component.onCompleted: {
        isPassword = (echoMode == TextInput.Password)
    }

    signal accepted

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: text_input_box_border
                border.color: "black"
            }
        },
        State {
            name: "warning"
            PropertyChanges {
                target: text_input_box_border
                border.color: "#F48914"
            }
        }
    ]

    Rectangle {
        id: text_input_box

        width: parent.width
        height: 22
        clip: true
        color: "#171717"
        radius: 3
    }

    DropShadow {
        anchors.fill: text_input_box
        radius: 1
        samples: 10
        horizontalOffset: 0
        verticalOffset: 1
        color: Qt.rgba(1, 1, 1, 0.15)
        source: text_input_box
    }

    InnerShadow {
        anchors.fill: text_input_box
        radius: 1
        samples: 10
        horizontalOffset: 0
        verticalOffset: radius
        color: "black"
        source: text_input_box
    }

    Item {
        clip: true
        anchors.fill: text_input_box
        anchors.leftMargin: root.textInputLeftMargin
        anchors.rightMargin: root.textInputRightMargin

        TextInput {
            id: text_input

            focus: true
            color: constants.fgColor
            selectionColor: "#31536e"
            selectByMouse: true
            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: text_input.echoMode == TextInput.Password ? 18 : 12
            echoMode: isPassword ? TextInput.Password : TextInput.Normal

            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: passwordShowButton.visible ? 3 + passwordShowButton.width : 3

            onAccepted: {
                root.accepted()
            }
        }

        DImageCheckButton {
            id: passwordShowButton
            visible: isPassword
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            inactivatedNomralImage: "images/hidepasswd.png"
            inactivatedHoverImage: inactivatedNomralImage
            inactivatedPressImage: inactivatedNomralImage

            activatedNomralImage: inactivatedNomralImage
            activatedHoverImage: inactivatedNomralImage
            activatedPressImage: inactivatedNomralImage

            onClicked: {
                if(text_input.echoMode == TextInput.Password){
                    text_input.echoMode = TextInput.Normal
                }
                else{
                    text_input.echoMode = TextInput.Password
                }

            }
        }
    }

    Rectangle {
        id: text_input_box_border
        radius: 3
        color: "transparent"

        anchors.fill:text_input_box
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            mouse.accepted = false
            if (root.state == "warning") {
                root.state = "normal"
            }
        }
    }
}
