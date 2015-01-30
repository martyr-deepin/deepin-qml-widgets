import QtQuick 2.0

DTextInput {
    id: textInput
    property int min: 0
    property int max: 65535
    property int step: 1
    property int precision: 0

    property int initValue:0
    property int value

    property color warningColor: "#FF8F00"
    property color modifiedColor: "#505050"

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

                onClicked: textInput.reset()
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
