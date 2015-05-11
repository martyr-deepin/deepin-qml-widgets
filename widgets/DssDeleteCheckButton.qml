import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {

    DConstants {id:dconstants}

    inactivatedNormalImage: dconstants.imagesPath + "delete_normal.png"
    inactivatedHoverImage: dconstants.imagesPath + "delete_hover.png"
    inactivatedPressImage: dconstants.imagesPath + "delete_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
