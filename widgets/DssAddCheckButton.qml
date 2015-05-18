import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DConstants.imagesPath + "add_normal.png"
    inactivatedHoverImage: DConstants.imagesPath + "add_hover.png"
    inactivatedPressImage: DConstants.imagesPath + "add_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
