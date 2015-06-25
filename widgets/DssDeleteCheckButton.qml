import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DPalette.imagesPath + "delete_normal.png"
    inactivatedHoverImage: DPalette.imagesPath + "delete_hover.png"
    inactivatedPressImage: DPalette.imagesPath + "delete_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
