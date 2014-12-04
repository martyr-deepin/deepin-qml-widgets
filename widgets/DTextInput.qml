import QtQuick 2.2
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

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
    property alias textInputBox: textInputBox
    property alias readOnly: text_input.readOnly
    property alias selectByMouse: text_input.selectByMouse
    property bool isPassword: false
    property bool showClearButton: false
    property bool keyboardOperationsEnabled: true

    property var cursorPosGetter: null

    Component.onCompleted: {
        isPassword = (echoMode == TextInput.Password)
    }

    signal accepted
    signal keyPressed (var event)

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
        height: parent.height
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
        id: textInputBox
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
            font.pixelSize: 12//text_input.echoMode == TextInput.Password ? 18 : 12
            echoMode: isPassword ? TextInput.Password : TextInput.Normal
            clip: true

            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: root.isPassword || root.showClearButton ? action_button_place_holder.width + 3 : 3

            onAccepted: {
                root.accepted()
            }

            Keys.enabled: !root.keyboardOperationsEnabled
            Keys.onPressed: { event.accepted = true; root.keyPressed(event) }
        }

        Item {
            id: action_button_place_holder
            width: height
            height: parent.height
            anchors.right: parent.right
        }

        Item {
            visible: !isPassword && root.showClearButton
            anchors.fill: action_button_place_holder

            DImageButton {
                normal_image: "images/clear_content_normal.png"
                hover_image: "images/clear_content_hover.png"
                press_image: "images/clear_content_press.png"

                anchors.centerIn: parent

                onClicked: text_input.text = ""
            }
        }

        Item {
            visible: isPassword
            anchors.fill: action_button_place_holder

            Rectangle {
                width: 1
                height: parent.height
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            Rectangle {
                width: parent.width - 1
                height: parent.height
                anchors.right: parent.right
                radius: 3
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: passwordShowButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                    }
                    GradientStop {
                        position: 1.0
                        color: passwordShowButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                    }
                }
            }

            DImageCheckButton {
                id: passwordShowButton
                anchors.verticalCenter: parent.verticalCenter
                inactivatedNormalImage: "images/password_show_normal.png"
                inactivatedHoverImage: "images/password_show_hover.png"
                inactivatedPressImage: "images/password_show_press.png"

                activatedNormalImage: "images/password_hide_normal.png"
                activatedHoverImage: "images/password_hide_hover.png"
                activatedPressImage: "images/password_hide_press.png"

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
    }

    Rectangle {
        id: text_input_box_border
        radius: 3
        color: "transparent"

        anchors.fill:text_input_box
    }

    DInputActions {
        id: actions

        canCopy: text_input.selectedText
        canCut: text_input.selectedText
        canPaste: text_input.canPaste
        canReset: text_input.text

        onCopyClicked: text_input.copy()
        onCutClicked: text_input.cut()
        onPasteClicked: text_input.paste()
        onResetClicked: text_input.text = ""
    }

    MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        propagateComposedEvents: true
        anchors.fill: textInputBox

        property bool pressed: false

        onPressed: {
            pressed = mouse.button == Qt.RightButton
            mouse.accepted = pressed
        }

        onReleased: {
            mouse.accepted = pressed
            pressed = false

            if (mouse.accepted && root.cursorPosGetter) {
                var pos = root.cursorPosGetter.getCursorPos()
                actions.show(pos.x, pos.y)
            }
        }
    }
}
