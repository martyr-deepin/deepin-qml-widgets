import QtQuick 2.1
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import Deepin.Widgets 1.0
Window {
    id:root
    width: 200
    height: 300
    x: 500

    property var tmplabels: {
        var tmpArray = new Array()
        for (var i = 0; i < 100; i ++){
            tmpArray.push(i.toString())
        }

        return tmpArray
    }
    Column {
        width: parent.width
        height: parent.height


        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }
        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet Orientation")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }
        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet Orientation")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }
        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet Orientation")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }
        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet Orientation")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }

        DCenterLine {
            leftWidth: 80
            centerPadding: 10
            title.text: dsTr("Tablet Orientation")
            content.sourceComponent: DComboBox {
                parentWindow: root
                menu.maxHeight: 100
                labels: tmplabels
                width: 100
                height: 30
                text: "test"
            }
        }

        DComboBox {
            parentWindow: root
            menu.maxHeight: 100
            labels: tmplabels
            width: 100
            height: 30
            text: "test"
        }
        ComboBox {
            currentIndex: 2
            model: tmplabels
            width: 200
            height: 100
            onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).color)
        }
    }
}
