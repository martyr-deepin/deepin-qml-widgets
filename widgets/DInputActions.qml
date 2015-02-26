import QtQuick 2.1
import DBus.Com.Deepin.Menu 1.0
import Deepin.Locale 1.0

Item {
    id: root_item
    property bool canCopy: true
    property bool canCut: true
    property bool canPaste: true
    property bool canReset: true

    signal copyClicked
    signal cutClicked
    signal pasteClicked
    signal selectAllClicked

    DLocale { id: dsslocale; domain: "deepin-qml-widgets" }

    MenuManager { id: manager; path: "/com/deepin/menu" }
    MenuObject {
        id: menu

        onItemInvoked: {
            switch(itemId) {
                case "copy":
                root_item.copyClicked(); break
                case "cut":
                root_item.cutClicked(); break
                case "paste":
                root_item.pasteClicked(); break
                case "select_all":
                root_item.selectAllClicked(); break
            }
        }
    }

    function dsTr(s) { return dsslocale.dsTr(s) }

    function show(x, y) {
        menu.path = manager.RegisterMenu()
        var menuCopy = {
            "itemId": "copy",
            "itemIcon": "",
            "itemIconHover": "",
            "itemIconInactive": "",
            "itemText": dsTr("Copy"),
            "isActive": canCopy,
            "checked": false,
            "itemSubMenu": {}
        }
        var menuCut = {
            "itemId": "cut",
            "itemIcon": "",
            "itemIconHover": "",
            "itemIconInactive": "",
            "itemText": dsTr("Cut"),
            "isActive": canCut,
            "checked": false,
            "itemSubMenu": {}
        }
        var menuPaste = {
            "itemId": "paste",
            "itemIcon": "",
            "itemIconHover": "",
            "itemIconInactive": "",
            "itemText": dsTr("Paste"),
            "isActive": canPaste,
            "checked": false,
            "itemSubMenu": {}
        }
        var menuSelectAll = {
            "itemId": "select_all",
            "itemIcon": "",
            "itemIconHover": "",
            "itemIconInactive": "",
            "itemText": dsTr("Select all"),
            "isActive": canReset,
            "checked": false,
            "itemSubMenu": {}
        }

        var menuJson = {
            "x": x, "y": y, "isDockMenu": false,
            "menuJsonContent": JSON.stringify({
                "items": [
                menuCopy,
                menuCut,
                menuPaste,
                menuSelectAll
                ]
                })
        }

        menu.ShowMenu(JSON.stringify(menuJson))
    }
}