import QtQuick 2.0

QtObject {
    //Please use the property below to replace these property
    property color bgColor: "#252627"
    property color fgColor: "#b4b4b4"
    property color fgDarkColor: "#505050"
    property color contentBgColor: "#1A1B1B"
    property color hoverColor: "#FFFFFF"
    property color activeColor: "#00BDFF"
    property color tuhaoColor: "#faca57"
    /////////////////////////////////////////////////////////

    property int leftMargin: 15
    property int rightMargin: 15

    readonly property color blackPanelBgColor: "#252627"
    readonly property color blackContentBgColor: "#1A1B1B"
    readonly property color blackContentSelectedColor: Qt.rgba(0, 0, 0, 0.4)
    readonly property color blackTextNormalColor: "#b4b4b4"
    readonly property color blackTextHoverColor: "#FFFFFF"
    readonly property color blackTextActiveColor: "#01BDFF"
    readonly property color blackWarningColor: "#FF8F00"

    readonly property color whitePanelBgColor: "#fafafa"
    readonly property color whiteContentBgColor: "#ffffff"
    readonly property color whiteContentSelectedColor: "#ffffff"
    readonly property color whiteTextNormalColor: "#474747"
    readonly property color whiteTextHoverColor: "#FFFFFF"
    readonly property color whiteTextActiveColor: "#2CA7F8"
    readonly property color whiteWarningColor: "#FF6100"
}
