/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

import QtQuick 2.2
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

FocusScope {
    id: root
    width: 160
    height: DPalette.buttonHeight + 1
    state: "normal"

    property alias echoMode: text_input.echoMode
    property alias text: text_input.text
    property int textInputRightMargin: DPalette.textRightMargin
    property int textInputLeftMargin: DPalette.textLeftMargin
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
                border.color: DPalette.outsideBorderObj.color
            }
        },
        State {
            name: "warning"
            PropertyChanges {
                target: text_input_box_border
                border.color: DPalette.warningColor
            }
        }
    ]

    Rectangle {
        id: text_input_box

        width: parent.width
        height: parent.height
        clip: true
        color: DPalette.tabBgColor
        radius: DPalette.normalRadius
    }

    DropShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: 1
        color: DPalette.inputGrooveColor
        source: text_input_box
    }

    InnerShadow {
        anchors.fill: text_input_box
        radius: 0
        samples: 16
        horizontalOffset: 0
        verticalOffset: radius
        color: DPalette.insideBorderObj.bottom.color
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
            color: DPalette.textNormalColor
            selectionColor: DPalette.textSelectedBgColor
            selectByMouse: true
            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: DPalette.fontSize
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
            width: DPalette.imageButtonWidth
            height: parent.height
            anchors.right: parent.right
        }

        Item {
            visible: !isPassword && root.showClearButton && text_input.text.trim() != ""
            anchors.fill: action_button_place_holder

            DImageButton {
                normal_image: DPalette.imagesPath + "clear_content_normal.png"
                hover_image: DPalette.imagesPath + "clear_content_hover.png"
                press_image: DPalette.imagesPath + "clear_content_press.png"

                anchors.centerIn: parent

                onClicked: text_input.text = ""
            }
        }

        DButtonFrame {
            topLeftRadius: 0
            bottomLeftRadius: 0
            width: DPalette.imageButtonWidth
            visible: isPassword
            anchors.verticalCenter: action_button_place_holder.verticalCenter
            anchors.right: action_button_place_holder.right
            // anchors.rightMargin:5

            DImageCheckButton {
                id: passwordShowButton
                anchors.verticalCenter: parent.verticalCenter
                inactivatedNormalImage: DPalette.imagesPath + "password_show_normal.png"
                inactivatedHoverImage: DPalette.imagesPath + "password_show_hover.png"
                inactivatedPressImage: DPalette.imagesPath + "password_show_press.png"

                activatedNormalImage: DPalette.imagesPath + "password_hide_normal.png"
                activatedHoverImage: DPalette.imagesPath + "password_hide_hover.png"
                activatedPressImage: DPalette.imagesPath + "password_hide_press.png"

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
        radius: DPalette.normalRadius
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
