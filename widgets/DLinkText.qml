import QtQuick 2.1

Text {
    color: "#0090ff"
    property url refLink
    
    MouseArea {
        anchors.fill: parent
        onClicked: Qt.openUrlExternally(refLink)
    }
}