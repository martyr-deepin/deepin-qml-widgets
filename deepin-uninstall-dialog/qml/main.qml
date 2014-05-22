import QtQuick 2.1
import QtQuick.Window 2.1
import Deepin.Locale 1.0
import Deepin.Widgets 1.0
import Helper 1.0

Window {
    id: messageBox
    color: "transparent"
    flags: Qt.Dialog | Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    width: 360
    height: 100

    property var externalObject: ExternalObject{}
    property int appId: 0

    signal actionInvoked(string actionId)

    function showDialog(icon, message, actions){
        appIcon.icon = icon
        messageLabel.text = message
        var actionNumber = parseInt(actions.length / 2)

        buttonRepeater.model.clear()
        appId += 1
        for(var i=0;i<actionNumber; i++){
            buttonRepeater.model.append({
                "actionId": actions[i*2],
                "label": actions[i*2 + 1],
                "appId": appId
            })
        }
        show()
        return appId
    }

    DialogBox {
        id: window
        anchors.fill: parent
        radius: 5

        MouseArea {
            anchors.fill: parent

            property int startX
            property int startY
            property bool holdFlag
            onPressed: {
                startX = mouse.x;
                startY = mouse.y;
                holdFlag = true;
            }
            onReleased: holdFlag = false;
            onPositionChanged: {
                if (holdFlag) {
                    messageBox.setX(messageBox.x + mouse.x - startX)
                    messageBox.setY(messageBox.y + mouse.y - startY)
                }
            }
        }

        DIcon {
            id: appIcon
            width: 64
            height: 64
            theme: "Deepin"
            icon: "deepin-media-player"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 19
        }

        DLabel {
            id: messageLabel
            anchors.left: appIcon.right
            anchors.leftMargin: 24
            anchors.top: appIcon.top
            font.pixelSize: 14
            text: "您确定要卸载“深度影院”吗？"
            width: parent.width - appIcon.width - appIcon.anchors.leftMargin * 2 - anchors.leftMargin
            wrapMode: TextEdit.WordWrap
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 6
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            spacing: 6

            Repeater {
                id: buttonRepeater
                model: ListModel {}
                delegate: DTransparentButton {
                    text: label
                    onClicked: {
                        mainObject.actionInvoked(appId, actionId)
                    }

                }
            }
        }
    }
}
