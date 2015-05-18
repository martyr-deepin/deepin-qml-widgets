import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DConstants.imagesPath + "multiselect_inactive_normal.png"
    inactivatedHoverImage: DConstants.imagesPath + "multiselect_inactive_hover.png"
    inactivatedPressImage: DConstants.imagesPath + "multiselect_active_normal.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
