import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import Deepin.Widgets 1.0

CheckBox {
    property int fontSize: 12
    property string imagesPath: DConstants.imagesPath

    text: "hello"
    style: CheckBoxStyle {
        background: Item {}
        indicator: Image {
            source: control.checked ? control.hovered ? imagesPath + "checkbox_checked_hover.png" : imagesPath + "checkbox_checked.png"
                                    : control.hovered ? imagesPath + "checkbox_unchecked_hover.png" : imagesPath + "checkbox_unchecked.png"
        }
        label: Text {
            color: DConstants.textNormalColor
            text: control.text
            font.pixelSize: control.fontSize
        }
    }
}
