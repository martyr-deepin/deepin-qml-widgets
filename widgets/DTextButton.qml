import QtQuick 2.1

Rectangle{
    id: textButton
    width: buttonHeader.width + buttonMiddle.width + buttonTail.width
    height: buttonHeader.height
    color: "transparent"
    property int minMiddleWidth: 50

    property alias text: title.text
    property alias textColor: title.color
    signal clicked

    DConstants {id: dconstants}

    QtObject { //enumeration for button image
        id: buttonImage
        property string headerNormal: dconstants.imagesPath + "button_left_normal.png"
        property string headerPress: dconstants.imagesPath + "button_left_press.png"
        property string middleNormal: dconstants.imagesPath + "button_center_normal.png"
        property string middlePress: dconstants.imagesPath + "button_center_press.png"
        property string tailNormal: dconstants.imagesPath + "button_right_normal.png"
        property string tailPress: dconstants.imagesPath + "button_right_press.png"
    }

    Row {
        anchors.top: parent.top
        anchors.left: parent.left

        Image{
            id: buttonHeader
            source: buttonImage.headerNormal
        }

        Image {
            id: buttonMiddle
            source: buttonImage.middleNormal
            width: title.width + 8 < minMiddleWidth ? minMiddleWidth : title.width + 8

            Text{
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: dconstants.textNormalColor
                font.pixelSize: 12
            }

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                width: parent.width
                height: parent.height
                onPressed: {
                    buttonHeader.source = buttonImage.headerPress
                    buttonMiddle.source = buttonImage.middlePress
                    buttonTail.source = buttonImage.tailPress
                }
                onReleased: {
                    buttonHeader.source = buttonImage.headerNormal
                    buttonMiddle.source = buttonImage.middleNormal
                    buttonTail.source = buttonImage.tailNormal
                }
                onClicked: {
                    textButton.clicked()
                }
            }
        }

        Image{
            id: buttonTail
            source: buttonImage.tailNormal
        }
    }
}
