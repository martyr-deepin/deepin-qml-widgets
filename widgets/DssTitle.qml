import QtQuick 2.0

DBaseLine {
    id: dssTitle
    width: parent.width
    height: dconstants.dssTitleStyle.height

    signal titleClicked
    property string text: ""

    DConstants {id:dconstants}

    leftLoader.sourceComponent: DssH1 {
        id: title
        font.weight: Font.DemiBold
        color: dconstants.dssTitleStyle.color
        text: dssTitle.text

        MouseArea {
            anchors.fill: parent
            onClicked: dssTitle.titleClicked()
        }
    }
}
