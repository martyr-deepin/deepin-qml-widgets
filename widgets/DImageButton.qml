import QtQuick 2.1

Item {
    id: button

    property url normal_image
    property url hover_image
    property url press_image
    property alias containsMouse: mouseArea.containsMouse

    property alias mouseArea: mouseArea
    property alias sourceSize: normalImage.sourceSize

    signal clicked
    signal entered
    signal exited

    property bool pressed: state == "normal"
    property bool transitionEnabled: false
    property int transitionDuration: 300

    state: "normal"

    states: [
        State {
            name: "normal"
            PropertyChanges { target: normalImage; opacity: 1 }
            PropertyChanges { target: hoverImage; opacity: 0 }
            PropertyChanges { target: pressImage; opacity: 0 }
        },
        State {
            name: "hovered"
            PropertyChanges { target: normalImage; opacity: 0 }
            PropertyChanges { target: hoverImage; opacity: 1 }
            PropertyChanges { target: pressImage; opacity: 0 }
        },
        State {
            name: "pressed"
            PropertyChanges { target: normalImage; opacity: 0 }
            PropertyChanges { target: hoverImage; opacity: 0 }
            PropertyChanges { target: pressImage; opacity: 1 }
        }
    ]

    transitions: Transition {
        from: "normal"; to: "hovered"
        reversible: true
        enabled: transitionEnabled
        NumberAnimation { properties: "opacity"; duration: transitionDuration }
    }

    width: normalImage.width;    height: normalImage.height

    Image {
        id: normalImage
        source: normal_image
    }

    Image {
        id: hoverImage
        anchors.centerIn: normalImage
        width: normalImage.width
        height: normalImage.height
        source: hover_image
    }

    Image {
        id: pressImage
        anchors.centerIn: normalImage
        width: normalImage.width
        height: normalImage.height
        source: press_image
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: { button.state = "hovered"; button.entered() }
        onExited: { button.state = "normal"; button.exited() }
        onPressed: { button.state = "pressed" }
        onReleased: { button.state = mouseArea.containsMouse ? "hovered" : "normal"}
        onClicked: button.clicked()
    }
}
