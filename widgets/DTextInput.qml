import QtQuick 2.2
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

FocusScope {
    id: root
    width: 160
    height: DConstants.buttonHeight + 1
    state: "normal"

    property alias echoMode: text_input.echoMode
    property alias text: text_input.text
    property int textInputRightMargin: DConstants.textRightMargin
    property int textInputLeftMargin: DConstants.textLeftMargin
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
                border.color: DConstants.outsideBorderObj.color
            }
        },
        State {
            name: "warning"
            PropertyChanges {
                target: text_input_box_border
                border.color: DConstants.warningColor
            }
        }
    ]

    Rectangle {
        id: text_input_box

        width: parent.width
        height: parent.height
        clip: true
        color: DConstants.tabBgColor
        radius: DConstants.normalRadius
    }

    DropShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: 1
        color: DConstants.inputGrooveColor
        source: text_input_box
    }

    InnerShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: radius
        color: DConstants.insideBorderObj.bottom.color
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
            color: DConstants.textNormalColor
            selectionColor: DConstants.textSelectedBgColor
            selectByMouse: true
            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: DConstants.fontSize
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
            width: DConstants.imageButtonWidth
            height: parent.height
            anchors.right: parent.right
        }

        Item {
            visible: !isPassword && root.showClearButton && text_input.text.trim() != ""
            anchors.fill: action_button_place_holder

            DImageButton {
                normal_image: DConstants.imagesPath + "clear_content_normal.png"
                hover_image: DConstants.imagesPath + "clear_content_hover.png"
                press_image: DConstants.imagesPath + "clear_content_press.png"

                anchors.centerIn: parent

                onClicked: text_input.text = ""
            }
        }

        DButtonFrame {
            topLeftRadius: 0
            bottomLeftRadius: 0
            width: DConstants.imageButtonWidth
            visible: isPassword
            anchors.verticalCenter: action_button_place_holder.verticalCenter
            anchors.right: action_button_place_holder.right
            // anchors.rightMargin:5

            DImageCheckButton {
                id: passwordShowButton
                anchors.verticalCenter: parent.verticalCenter
                inactivatedNormalImage: DConstants.imagesPath + "password_show_normal.png"
                inactivatedHoverImage: DConstants.imagesPath + "password_show_hover.png"
                inactivatedPressImage: DConstants.imagesPath + "password_show_press.png"

                activatedNormalImage: DConstants.imagesPath + "password_hide_normal.png"
                activatedHoverImage: DConstants.imagesPath + "password_hide_hover.png"
                activatedPressImage: DConstants.imagesPath + "password_hide_press.png"

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
        radius: DConstants.normalRadius
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
