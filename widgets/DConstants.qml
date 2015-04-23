import QtQuick 2.0
import Deepin.Widgets 1.0

QtObject {
    //Please use the property below to replace these property
    property color bgColor: "#252627"
    property color fgColor: "#b4b4b4"
    property color fgDarkColor: "#505050"
    property color hoverColor: "#FFFFFF"
    property color activeColor: "#00BDFF"
    property color tuhaoColor: "#faca57"
    /////////////////////////////////////////////////////////

    property int leftMargin: 15
    property int rightMargin: 15

    property var styleController: DWidgetStyleController { }
    property var styleList: styleController.styleList
    property string currentWidgetStyle: styleController.currentWidgetStyle
    property string imagesPath: styleController.imagesPath

    property var configObj: styleController.configObject
    property var generalConfigObj: configObj.General
    property var separatorStyle: configObj.Separator
    property var switchButtonStyle: configObj.SwitchButton

    // helper functions
    function marshalJSON(value) {
        var valueJSON = JSON.stringify(value);
        return valueJSON
    }

    //basis property
    onGeneralConfigObjChanged: {
        panelBgColor = generalConfigObj.panelBgColor
        contentBgColor = generalConfigObj.contentBgColor
        contentSelectedColor = generalConfigObj.contentSelectedColor
        itemTipColor = generalConfigObj.itemTipColor
        textNormalColor = generalConfigObj.textNormalColor
        textHoverColor = generalConfigObj.textHoverColor
        textActiveColor = generalConfigObj.textActiveColor
        warningColor = generalConfigObj.warningColor
    }

    property color panelBgColor: "#252627"
    property color contentBgColor: "#1A1B1B"
    property color contentSelectedColor: Qt.rgba(0, 0, 0, 0.4)
    property color itemTipColor: "#505050"
    property color textNormalColor: "#b4b4b4"
    property color textHoverColor: "#FFFFFF"
    property color textActiveColor: "#01BDFF"
    property color warningColor: "#FF8F00"
}
