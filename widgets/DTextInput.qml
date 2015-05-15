import QtQuick 2.2
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

FocusScope {
    id: root
    width: 160
    height: dconstants.buttonHeight + 1
    state: "normal"

    DConstants {id: dconstants}

    property alias echoMode: text_input.echoMode
    property alias text: text_input.text
    property int textInputRightMargin: dconstants.textRightMargin
    property int textInputLeftMargin: dconstants.textLeftMargin
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
                border.color: dconstants.outsideBorderObj.color
            }
        },
        State {
            name: "warning"
            PropertyChanges {
                target: text_input_box_border
                border.color: dconstants.warningColor
            }
        }
    ]

    Rectangle {
        id: text_input_box

        width: parent.width
        height: parent.height
        clip: true
        color: dconstants.tabBgColor
        radius: dconstants.normalRadius
    }

    DropShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: 1
        color: dconstants.inputGrooveColor
        source: text_input_box
    }

    InnerShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: radius
        color: dconstants.insideBorderObj.bottom.color
        source: text_input_box
    }

    Item {
        id: textInputBox
        clip: true
        anchors.fill: text_input_box
        // anchors.leftMargin: root.textInputLeftMargin
        // anchors.rightMargin: root.textInputRightMargin

        TextInput {
            id: text_input

            focus: true
            color: dconstants.textNormalColor
            selectionColor: dconstants.textSelectedBgColor
            selectByMouse: true
            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: dconstants.fontSize
            echoMode: isPassword ? TextInput.Password : TextInput.Normal
            clip: true

            anchors.fill: parent
            anchors.leftMargin: root.textInputLeftMargin
            anchors.rightMargin: root.isPassword || root.showClearButton ? action_button_place_holder.width + root.textInputRightMargin : root.textInputRightMargin

            onAccepted: {
                root.accepted()
            }

            Keys.enabled: !root.keyboardOperationsEnabled
            Keys.onPressed: {root.keyPressed(event) }
        }

        Item {
            id: action_button_place_holder
            width: dconstants.imageButtonWidth
            height: parent.height
            anchors.right: parent.right
        }

        Item {
            visible: !isPassword && root.showClearButton && text_input.text.trim() != ""
            anchors.fill: action_button_place_holder

            DImageButton {
                normal_image: dconstants.imagesPath + "clear_content_normal.png"
                hover_image: dconstants.imagesPath + "clear_content_hover.png"
                press_image: dconstants.imagesPath + "clear_content_press.png"

                anchors.centerIn: parent

                onClicked: text_input.text = ""
            }
        }

        DButtonFrame {
            topLeftRadius: 0
            bottomLeftRadius: 0
            width: dconstants.imageButtonWidth
            visible: isPassword
            anchors.verticalCenter: action_button_place_holder.verticalCenter
            anchors.right: action_button_place_holder.right
            // anchors.rightMargin:5

            DImageCheckButton {
                id: passwordShowButton
                anchors.verticalCenter: parent.verticalCenter
                inactivatedNormalImage: dconstants.imagesPath + "password_show_normal.png"
                inactivatedHoverImage: dconstants.imagesPath + "password_show_hover.png"
                inactivatedPressImage: dconstants.imagesPath + "password_show_press.png"

                activatedNormalImage: dconstants.imagesPath + "password_hide_normal.png"
                activatedHoverImage: dconstants.imagesPath + "password_hide_hover.png"
                activatedPressImage: dconstants.imagesPath + "password_hide_press.png"

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
        radius: dconstants.normalRadius
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
        onSelectAllClicked: text_input.selectAll()
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
