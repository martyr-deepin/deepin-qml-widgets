import Deepin.Locale 1.0
import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    DLocale {
        id:t
        domain:"DDE" //mo file.  See also man 3 dgettext

        // NOTES:  1. LC_XX will not be used when set LANGUAGE environment  2. LANG environment is lest important(only used when LC_XX not set)
    }
    function dsTr(s) { return t.dsTr(s) } // current deepin-lupdate only recognize dsTr function, so we must create one.

    width: t.lang == "zh" ? 800 : 200
    height: 200
    Column {
        width: parent.width
        height: 200
        Text {
            text: "Current locale TIME :" + t.localeTIME // test read locale variable
        }
        Text {
            id: x
            text: dsTr("guest")
        }
        SubItem { } //test submodule use dsTr
    }
}
