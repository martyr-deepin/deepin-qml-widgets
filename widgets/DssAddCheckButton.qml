import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DPalette.imagesPath + "add_normal.png"
    inactivatedHoverImage: DPalette.imagesPath + "add_hover.png"
    inactivatedPressImage: DPalette.imagesPath + "add_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
