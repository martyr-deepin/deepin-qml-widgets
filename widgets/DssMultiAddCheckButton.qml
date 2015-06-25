import QtQuick 2.1
import Deepin.Widgets 1.0

DImageCheckButton {
    inactivatedNormalImage: DPalette.imagesPath + "multiselect_inactive_normal.png"
    inactivatedHoverImage: DPalette.imagesPath + "multiselect_inactive_hover.png"
    inactivatedPressImage: DPalette.imagesPath + "multiselect_active_normal.png"

    activatedNormalImage: inactivatedPressImage
    activatedHoverImage: inactivatedPressImage
    activatedPressImage: inactivatedPressImage
}
