import QtQuick 2.0
import Deepin.Widgets 1.0

DTextInput {
    id: textInput
    property real min: 0
    property real max: 65535
    property real step: 1
    property int precision: 0

    property real initValue:0
    property real value

    property color warningColor: DPalette.warningColor
    property color modifiedColor: DPalette.textHintColor

    textInput.validator: RegExpValidator { regExp: /^-?([0-9]|\.)*$/ }

    textInput.anchors.rightMargin: 3 + buttonBox.width

    Component.onCompleted: {
        if (textInput.text == ""){
            textInput.text = initValue.toFixed(precision)
        } else if (_validate()) {
            value = parseFloat(textInput.text)
            initValue = value
        } else {
            initValue = min
            textInput.text = initValue.toFixed(precision)
        }
    }

    function setValue(i){
        textInput.text = i.toFixed(precision)
    }

    function _validate() {
        var value =  parseFloat(textInput.text)
        return min <= value && value <= max
    }

    Connections{
        target: textInput

        onTextChanged: check_valid_timer.restart()

        onActiveFocusChanged: {
            if (!textInput.activeFocus) {
                if (!_validate()) {
                    textInput.reset()
                } else {
                    textInput.initValue = value
                    warning_label.visible = false
                }
            }
        }
    }

    Connections {
        target: increaseButton.mouseArea
        onPressAndHold: {
            holdTimer.isIncrease = true
            holdTimer.restart()
        }
        onReleased: {
            holdTimer.stop()
        }
    }

    Connections {
        target: decreaseButton.mouseArea
        onPressAndHold: {
            holdTimer.isIncrease = false
            holdTimer.restart()
        }
        onReleased: {
            holdTimer.stop()
        }
    }

    Timer {
        id: check_valid_timer
        interval: 300

        onTriggered: {
            if (textInput._validate()) {
                if (warning_label.visible) {
                    warning_label.color = modifiedColor
                }

                var textValue = parseFloat(textInput.text)
                textInput.value = textValue.toFixed(textInput.precision)
            } else  {
                warning_label.color = warningColor
                warning_label.visible = true
            }
        }
    }

    Timer {
        id: holdTimer
        repeat: true
        interval: 50
        property bool isIncrease: true
        onTriggered: {
            if(isIncrease){
                increase()
            }
            else{
                decrease()
            }
        }
    }

    function reset() {
        textInput.text = initValue
        warning_label.visible = false
    }

    function increase(){
        if(value <= max - step){
            setValue(value + step)
        }
        else{
            setValue(max)
        }
    }

    function decrease(){
        if(value >= min + step){
            setValue(value - step)
        }
        else{
            setValue(min)
        }
    }

    Text {
        id: warning_label
        visible: false
        font.pixelSize: 12
        text: "%1-%2".arg(min).arg(max)

        anchors.right: parent.right
        anchors.rightMargin: buttonBox.width + 5
        anchors.verticalCenter: parent.verticalCenter
    }

    Row {
        id: buttonBox
        height: parent.height
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: -1

        DButtonFrame {
            width: DPalette.imageButtonWidth
            height: parent.height
            topLeftRadius: 0
            topRightRadius: 0
            bottomLeftRadius: 0
            bottomRightRadius: 0

            DImageButton {
                id: resetButton
                transitionEnabled: true
                anchors.verticalCenter: parent.verticalCenter
                normal_image: DPalette.imagesPath + "restore_normal.png"
                hover_image: DPalette.imagesPath + "restore_hover.png"
                press_image: DPalette.imagesPath + "restore_press.png"

                onClicked: textInput.reset()
            }
        }

        DButtonFrame {
            width: DPalette.imageButtonWidth
            height: parent.height
            topLeftRadius: 0
            topRightRadius: 0
            bottomLeftRadius: 0
            bottomRightRadius: 0

            DImageButton {
                id: increaseButton
                transitionEnabled: true
                anchors.verticalCenter: parent.verticalCenter
                normal_image: DPalette.imagesPath + "spinner_increase_normal.png"
                hover_image: DPalette.imagesPath + "spinner_increase_hover.png"
                press_image: DPalette.imagesPath + "spinner_increase_press.png"

                onClicked: increase()
            }
        }

        DButtonFrame {
            width: DPalette.imageButtonWidth
            height: parent.height
            topLeftRadius: 0
            bottomLeftRadius: 0

            DImageButton{
                id: decreaseButton
                transitionEnabled: true
                anchors.verticalCenter: parent.verticalCenter
                normal_image: DPalette.imagesPath + "spinner_decrease_normal.png"
                hover_image: DPalette.imagesPath + "spinner_decrease_hover.png"
                press_image: DPalette.imagesPath + "spinner_decrease_press.png"

                onClicked: decrease()
            }
        }
    }
}
