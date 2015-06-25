import QtQuick 2.0
import Deepin.Widgets 1.0

DBaseLine {
    id: dssTitle
    width: parent.width
    height: DPalette.dssTitleStyle.height

    signal titleClicked
    property string text: ""

    leftLoader.sourceComponent: DssH1 {
        id: title
        font.weight: Font.DemiBold
        color: DPalette.dssTitleStyle.color
        text: dssTitle.text

        MouseArea {
            anchors.fill: parent
            onClicked: dssTitle.titleClicked()
        }
    }
}
