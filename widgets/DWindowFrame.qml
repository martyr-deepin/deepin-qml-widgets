import QtQuick 2.1
import QtGraphicalEffects 1.0
import Deepin.Widgets 1.0

Item {
    id: window

    property int frameRadius: DPalette.normalRadius
    property int shadowRadius: DPalette.popupShadowObj.glowRadius
    property alias frame: frame

    default property alias content: container.children

    Rectangle {
        id: frame
        anchors.centerIn: parent
        color: DPalette.contentBgColor
        radius: frameRadius
        border.width: 1
        border.color: DPalette.popupShadowObj.borderColor
        width: window.width - (shadowRadius + frameRadius) * 2
        height: window.height - (shadowRadius + frameRadius) * 2

        Item {
            id: container
            anchors.fill: parent
        }
    }

    RectangularGlow {
        id: shadow
        z: -1
        anchors.fill: frame
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        anchors.topMargin: DPalette.popupShadowObj.verticalOffset
        glowRadius: shadowRadius
        spread: 0.3
        color: DPalette.popupShadowObj.color
        cornerRadius: frame.radius + shadowRadius
        visible: true
    }
}
