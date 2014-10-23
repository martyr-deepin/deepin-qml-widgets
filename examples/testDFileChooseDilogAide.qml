import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    height: 200
    width: 400

    Text {
        anchors.fill: parent
        text:lll.getIconName("/home/match/Desktop/")
    }

    DFileChooseDialogAide {
        id:lll

    }
}
