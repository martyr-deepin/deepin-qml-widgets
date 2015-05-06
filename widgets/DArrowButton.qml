import QtQuick 2.1
import Deepin.Widgets 1.0

DImageButton {

    DConstants {id:dconstants}

    readonly property string directionLeft: "left"
    readonly property string directionRight: "right"
    readonly property string directionUp: "up"
    readonly property string directionDown: "down"

    property string direction: "right"

    transitionEnabled: true

    normal_image: dconstants.imagesPath + "arrow_" + direction +"_normal.png"
    hover_image: dconstants.imagesPath + "arrow_" + direction +"_hover.png"
    press_image: dconstants.imagesPath + "arrow_" + direction + "_press.png"
}
