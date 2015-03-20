import QtQuick 2.1

Item {
    id: button

    property url normal_image
    property url hover_image
    property url press_image
    property alias containsMouse: mouseArea.containsMouse

    property alias mouseArea: mouseArea
    property alias sourceSize: image.sourceSize
    property alias drawBackground: background.visible
    property int minMiddleWidth: 10
    property bool lightVersion: false

    signal clicked
    signal entered
    signal exited

    property bool pressed: state == "pressed"

    state: "normal"
    states: [
        State {
            name: "normal"
            PropertyChanges { target: image; source: button.normal_image }
            PropertyChanges { target: bg_head; source: "images/%1button_left_normal.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_body; source: "images/%1button_center_normal.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_tail; source: "images/%1button_right_normal.png".arg(lightVersion ? "light_" : "") }
        },
        State {
            name: "hovered"
            PropertyChanges { target: image; source: button.hover_image }
            PropertyChanges { target: bg_head; source: "images/%1button_left_normal.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_body; source: "images/%1button_center_normal.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_tail; source: "images/%1button_right_normal.png".arg(lightVersion ? "light_" : "") }
        },
        State {
            name: "pressed"
            PropertyChanges { target: image; source: button.press_image }
            PropertyChanges { target: bg_head; source: "images/%1button_left_press.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_body; source: "images/%1button_center_press.png".arg(lightVersion ? "light_" : "") }
            PropertyChanges { target: bg_tail; source: "images/%1button_right_press.png".arg(lightVersion ? "light_" : "") }
        }
    ]

    width: background.visible ? background.width : image.width
    height: background.visible ? background.height : image.height

    Item {
        id: background
        width: bg_head.width + bg_body.width + bg_tail.width
        height: bg_head.height
        visible: false

        Image { id: bg_head }
        Image {
            id: bg_body
            width: Math.max(image.width + 8, button.minMiddleWidth)
            anchors.left: bg_head.right
        }
        Image {
            id: bg_tail
            anchors.right: parent.right
        }
    }

    Image { id: image; anchors.centerIn: parent }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: { button.state = "hovered"; button.entered() }
        onExited: { button.state = "normal"; button.exited() }
        onPressed: { button.state = "pressed" }
        onReleased: { button.state = mouseArea.containsMouse ? "hovered" : "normal" }
        onClicked: button.clicked()
    }
}
