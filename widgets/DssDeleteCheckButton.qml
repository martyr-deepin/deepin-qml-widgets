import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DConstants.imagesPath + "delete_normal.png"
    inactivatedHoverImage: DConstants.imagesPath + "delete_hover.png"
    inactivatedPressImage: DConstants.imagesPath + "delete_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
