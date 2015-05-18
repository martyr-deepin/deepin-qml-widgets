pragma Singleton
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

    property var styleList: DUIStyle.styleList
    property string currentWidgetStyle: DUIStyle.currentWidgetStyle
    property string imagesPath: DUIStyle.imagesPath


    property var configObj: DUIStyle.configObject
    property var generalConfigObj: configObj.General
    property var outsideBorderObj: generalConfigObj.outsideBorder
    property var insideBorderObj: generalConfigObj.insideBorder
    property var popupShadowObj: generalConfigObj.popupShadow
    property var buttonGradientObj: generalConfigObj.buttonGradient
    property var tooltipGradientObj: generalConfigObj.tooltipGradient

    property var separatorStyle: configObj.Separator
    property var switchButtonStyle: configObj.SwitchButton
    property var dssTitleStyle: configObj.dssTitle
    property var scrollBarStyle: configObj.ScrollBar

    //basis property
    onGeneralConfigObjChanged: {
        contentBgColor = generalConfigObj.contentBgColor
        panelBgColor = generalConfigObj.panelBgColor
        tabBgColor = generalConfigObj.tabBgColor
        radioItemSelectedColor = generalConfigObj.radioItemSelectedColor
        tooltipBorderColor = generalConfigObj.tooltipBorderColor
        textSelectedBgColor = generalConfigObj.textSelectedBgColor
        inputGrooveColor = generalConfigObj.inputGrooveColor
        buttonGrooveColor = generalConfigObj.buttonGrooveColor
        textActiveColor = generalConfigObj.textActiveColor
        textHoverColor = generalConfigObj.textHoverColor
        textNormalColor = generalConfigObj.textNormalColor
        textHintColor = generalConfigObj.textHintColor
        linkColor = generalConfigObj.linkColor
        itemTipColor = generalConfigObj.itemTipColor
        warningColor = generalConfigObj.warningColor
    }

    property color contentBgColor: "#1A1B1B"
    property color panelBgColor: "#252627"
    property color tabBgColor: "#1d1d1d"
    property color radioItemSelectedColor: "#66000000"
    property color tooltipBorderColor: "#26ffffff"
    property color textSelectedBgColor: "#276ea7"
    property color inputGrooveColor: "#0cffffff"
    property color buttonGrooveColor: "#02000000"
    property color textActiveColor: "#01BDFF"
    property color textHoverColor: "#FFFFFF"
    property color textNormalColor: "#b4b4b4"
    property color textHintColor: "#505050"
    property color linkColor: "#1b85ff"
    property color itemTipColor: "#fdbd25"
    property color warningColor: "#FF8F00"

    //basis width and height
    readonly property int buttonHeight: 22
    readonly property int expandHeaderHeight: 30
    readonly property int contentHeaderHeight: 38
    readonly property int radioItemHeight: 30
    readonly property int headerLeftMargin: 14
    readonly property int headerRightMargin: 14
    readonly property int textLeftMargin: 6
    readonly property int textRightMargin: 6
    readonly property int buttonMargin: 8
    readonly property int textButtonMinWidth: 70
    readonly property int imageButtonWidth: 24
    readonly property int fontSize: 12
    readonly property int normalRadius: 3

    // helper functions
    function marshalJSON(value) {
        var valueJSON = JSON.stringify(value);
        return valueJSON
    }
}
