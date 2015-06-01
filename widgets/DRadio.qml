import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import Deepin.Widgets 1.0

RadioButton {
    property int fontSize: 12
    property string imagesPath: DConstants.imagesPath

    style: RadioButtonStyle {
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? imagesPath + "radio_selected_hover.png" : imagesPath + "radio_selected.png"
                                    : control.hovered ? imagesPath + "radio_unselected_hover.png" : imagesPath + "radio_unselected.png"
        }
        label: Text {
            color: Qt.rgba(1, 1, 1, 0.5)
            text: control.text
            font.pixelSize: control.fontSize
        }
    }
}
