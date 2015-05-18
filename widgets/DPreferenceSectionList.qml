// Notice: this file is not intend to be used separately,
// there must be a item called `root' which has a property named `currentSectionId'
// and accessable from this scope to work properly.
import QtQuick 2.1
import Deepin.Widgets 1.0

ListView {
    id: listview
    width: 0
    height: childrenRect.height

    property var sections
    property int maxWidth: 200
    property int cellHeight: 24

    model: ListModel {
        Component.onCompleted: {
            var sections = listview.sections || []
            for (var i = 0; i < sections.length; i++) {
                append(sections[i])
            }
        }
    }
    delegate: Component {
        Column {
            id: main_column
            state: "normal"
            width: Math.max(wrapper.width, sub.x + sub.width)
            height: childrenRect.height

            Component.onCompleted: {
                root.anotherSectionCompleted()
                listview.width = Math.max(main_column.width, listview.width)
            }

            states: [
                State {
                    name: "normal"
                    PropertyChanges {
                        target: txt
                        color: "#b4b4b4"
                    }
                },
                State {
                    name: "hover"
                    PropertyChanges {
                        target: txt
                        color: "white"
                    }
                },
                State {
                    name: "selected"
                    PropertyChanges {
                        target: txt
                        color: DConstants.activeColor
                    }
                }
            ]

            property bool isParent: subSections.count != 0

            onStateChanged: {
                if (state == "selected") {
                    root.changeIndicatorPos(main_column.parent.mapToItem(root, main_column.x, main_column.y).y)
                }
            }

            Connections {
                target: root

                onCurrentSectionIdChanged: {
                    if (sectionId == root.currentSectionId) {
                        main_column.state = "selected"
                    } else {
                        main_column.state = "normal"
                    }
                }
            }

            Item {
                id: wrapper
                width: Math.min(txt.implicitWidth + leftRightMargin * 2, listview.maxWidth)
                height: listview.cellHeight

                property int leftRightMargin: 10

                Text {
                    id: txt
                    width: wrapper.width - wrapper.leftRightMargin * 2
                    text: sectionName
                    elide: Text.ElideRight
                    font.pixelSize: 13
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: main_column_mouse
                    hoverEnabled: true
                    anchors.fill: parent

                    onEntered: root.currentSectionId == sectionId ? main_column.state = "selected" : main_column.state = "hover"
                    onExited: root.currentSectionId == sectionId ? main_column.state = "selected" : main_column.state = "normal"

                    onClicked: {
                        root.currentSectionId = sectionId
                    }
                }
            }

            Loader {
                id: sub
                x: 10
                active: main_column.isParent
                source: "DPreferenceSectionList.qml"
                asynchronous: true
                onLoaded: {
                    item.model = subSections
                    item.width = main_column.width - 10
                }
            }
        }
    }
}
