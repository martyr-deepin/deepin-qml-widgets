import QtQuick 2.1
import Deepin.Widgets 1.0

DImageButton {

    property string widgetStyle:{
        switch (styleController.currentWidgetStyle){
        case DWidgetStyleController.StyleBlack:
            return "black"
        case DWidgetStyleController.StyleWhite:
            return "white"
        }
    }

    DWidgetStyleController {
        id: styleController
    }

    readonly property string directionLeft: "left"
    readonly property string directionRight: "right"
    readonly property string directionUp: "up"
    readonly property string directionDown: "down"

    property string direction: "right"

    normal_image: "images/" + widgetStyle + "_arrow_" + direction +"_normal.png"
    hover_image: "images/" + widgetStyle + "_arrow_" + direction +"_hover.png"
    press_image: "images/" + widgetStyle + "_arrow_" + direction + "_press.png"
}
