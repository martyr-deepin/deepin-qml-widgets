import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    DConstants {id: dconstants}

    inactivatedNormalImage: dconstants.imagesPath + "multiselect_inactive_normal.png"
    inactivatedHoverImage: dconstants.imagesPath + "multiselect_inactive_hover.png"
    inactivatedPressImage: dconstants.imagesPath + "multiselect_active_normal.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
