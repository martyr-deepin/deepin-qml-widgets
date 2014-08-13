import QtQuick 2.1
import QtQuick.Window 2.1
import Deepin.Locale 1.0
import Deepin.Widgets 1.0

DWindow {
    id: messageBox
    color: "transparent"
    flags: Qt.Dialog | Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    width: Math.max(360, realContent.width + (window.frameRadius + window.shadowRadius) * 2)
    height: 150

    shadowWidth: 15

    property int appId: 0

    function showDialog(icon, message, warning, actions){
        appIcon.icon = icon
        messageLabel.text = message
        warningLabel.text = warning
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

    DDialogBox {
        id: window
        anchors.fill: parent
        radius: 5

        DDragableArea {
            anchors.fill: parent
            window: messageBox
        }

        Item {
            id: realContent
            width: Math.max(360 - (window.frameRadius + window.shadowRadius) * 2,
                appIcon.width + appIcon.anchors.leftMargin + labelColumn.width + labelColumn.anchors.leftMargin * 2)
            height: parent.height

            DIcon {
                id: appIcon
                width: 48
                height: 48
                theme: "Deepin"
                icon: "deepin-media-player"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Column {
                id: labelColumn
                width: messageLabel.width
                anchors.top: appIcon.top
                anchors.left: appIcon.right
                anchors.leftMargin: 20
                spacing: 4

                DLabel {
                    id: messageLabel
                    font.pixelSize: 12
                    text: "Are you sure to remove \"Deepin Movie\""
                    color: "#f0f0f0"
                    width: contentWidth
                }

                DLabel {
                    id: warningLabel
                    font.pixelSize: 10
                    color: "#c99653"
                    text: "All dependences will be removed."
                    width: realContent.width
                    wrapMode: TextEdit.WordWrap
                }
            }

        } // end of item

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 6

            Repeater {
                id: buttonRepeater
                model: ListModel {
                    ListElement {
                        actionId: "1"
                        label: "No"
                        appId: 1
                    }
                    ListElement {
                        actionId: "2"
                        label: "Yes"
                        appId: 2
                    }
                }
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
