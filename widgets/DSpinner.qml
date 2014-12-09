import QtQuick 2.0

DTextInput {
    property int min: 0
    property int max: 65535
    property int step: 1
    property int precision: 0

    property int initValue:0
    property int value

    textInput.validator: RegExpValidator { regExp: /^-?([0-9]|\.)*$/ }

    textInput.anchors.rightMargin: 3 + buttonBox.width

    Component.onCompleted: {
        if (textInput.text == ""){
            textInput.text = initValue.toFixed(precision)
        }
        else{
            if (_validate()) {
                value = parseFloat(textInput.text)
                initValue = value
            } else {
                initValue = min
                textInput.text = initValue.toFixed(precision)
            }
        }
    }

    function setValue(i){
        textInput.text = i.toFixed(precision)
    }

    function _validate() {
        var value =  parseFloat(textInput.text)
        return min <= value && value <= max
    }

    function _changeTextToValid() {
        if (!_validate()) {
            var value = parseFloat(textInput.text)
            if (isNaN(value)) {
                textInput.text = initValue.toFixed(precision)
            } else {
                textInput.text = Math.min(max, Math.max(min, value)).toFixed(precision)
            }
        }
    }

    Connections{
        target: textInput

        onTextChanged: {
            if (_validate()) {
                var textValue = parseFloat(textInput.text)
                value = textValue.toFixed(precision)
            } else  {
                validate_timer.restart()
            }
        }

        onActiveFocusChanged: {
            if (textInput.activeFocus) return
            _changeTextToValid()
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
        id: validate_timer
        interval: 1000
        onTriggered: _changeTextToValid()
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

    Row {
        id: buttonBox
        parent: textInputBox
        height: parent.height
        anchors.right: parent.right

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        Item {
            width: resetButton.width
            height: parent.height

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: resetButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                    }
                    GradientStop {
                        position: 1.0
                        color: resetButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                    }
                }
            }

            DImageButton {
                id: resetButton
                anchors.verticalCenter: parent.verticalCenter
                normal_image: "images/restore_normal.png"
                hover_image: "images/restore_hover.png"
                press_image: "images/restore_press.png"

                onClicked: textInput.text = initValue
            }
        }

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        Item {
            width: increaseButton.width
            height: parent.height

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: increaseButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                    }
                    GradientStop {
                        position: 1.0
                        color: increaseButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                    }
                }
            }

            DImageButton {
                id: increaseButton
                anchors.verticalCenter: parent.verticalCenter
                normal_image: "images/spinner_increase_normal.png"
                hover_image: "images/spinner_increase_hover.png"
                press_image: "images/spinner_increase_press.png"

                onClicked: increase()
            }
        }

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        Item {
            width: decreaseButton.width
            height: parent.height

            Rectangle {
                anchors.fill: parent
                radius: 3
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: decreaseButton.pressed ? Qt.rgba(0, 0, 0, 0.05) : Qt.rgba(1, 1, 1, 0.05)
                    }
                    GradientStop {
                        position: 1.0
                        color: decreaseButton.pressed ? Qt.rgba(0, 0, 0, 0) : Qt.rgba(1, 1, 1, 0)
                    }
                }
            }

            DImageButton{
                id: decreaseButton
                anchors.verticalCenter: parent.verticalCenter
                normal_image: "images/spinner_decrease_normal.png"
                hover_image: "images/spinner_decrease_hover.png"
                press_image: "images/spinner_decrease_press.png"

                onClicked: decrease()
            }
        }
    }
}
