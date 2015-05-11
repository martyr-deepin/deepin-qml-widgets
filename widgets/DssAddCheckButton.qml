import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {

    DConstants {id:dconstants}

    inactivatedNormalImage: dconstants.imagesPath + "add_normal.png"
    inactivatedHoverImage: dconstants.imagesPath + "add_hover.png"
    inactivatedPressImage: dconstants.imagesPath + "add_press.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
