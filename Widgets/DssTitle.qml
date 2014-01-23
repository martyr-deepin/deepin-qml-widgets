import QtQuick 2.0

DBaseLine {
    id: dssTitle
    width: parent.width
    height: 48

    property string text: ""

    property var dconstants: DConstants {}

    leftLoader.sourceComponent: DssH1 {
        id: title
        font.bold: true
        style: Text.Raised
        styleColor: Qt.rgba(0, 0, 0, 0.9)
        color: "white"
        text: dssTitle.text
    }
}
