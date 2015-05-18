pragma Singleton
import QtQuick 2.3
import Deepin.Widgets 1.0

// DPalette is a copy of DConstants but made singleton.
// It's created intend to replace DConstants and to make your code more
// elegant, for example:
// If you have `DConstants { id: dconstants }' in your main.qml, you may
// refer it as `dconstants' in your other qml files, but as you can see,
// it's totally disaster when you want to use your widgets in other places.
// With DPalette, you just need to `import Deepin.Widgets 1.0', and use
// it like `DPalette.someColor', Qt will create the instance for you.

QtObject {
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
    property var popupMenuObj: generalConfigObj.popupMenu

    property var separatorStyle: configObj.Separator
    property var switchButtonStyle: configObj.SwitchButton

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
    readonly property int menuItemHeight: 24
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
