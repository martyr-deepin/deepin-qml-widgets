import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import Deepin.Widgets 1.0

CheckBox {
    property int fontSize: 12

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

    text: "hello"
    style: CheckBoxStyle {
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? "images/" + widgetStyle + "_checkbox_checked_hover.png" : "images/" + widgetStyle + "_checkbox_checked.png"
                                    : control.hovered ? "images/" + widgetStyle + "_checkbox_unchecked_hover.png" : "images/" + widgetStyle + "_checkbox_unchecked.png"
        }
        label: Text {
            color: Qt.rgba(1, 1, 1, 0.5)
            text: control.text
            font.pixelSize: control.fontSize
        }
    }
}
