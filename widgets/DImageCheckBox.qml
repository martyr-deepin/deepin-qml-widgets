import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import Deepin.Widgets 1.0

CheckBox {
    property int fontSize: 12
    property url imageSource
    property int spacing: 2

    DConstants {id: dconstants}

    text: "hello"
    style: CheckBoxStyle {
        spacing: control.spacing
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? dconstants.imagesPath + "checkbox_checked_hover.png" : dconstants.imagesPath + "checkbox_checked.png"
                                    : control.hovered ? dconstants.imagesPath + "checkbox_unchecked_hover.png" : dconstants.imagesPath + "checkbox_unchecked.png"
        }
        label: Image {
            source: control.imageSource
        }
    }
}
