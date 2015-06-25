import QtQuick 2.1
import Deepin.Widgets 1.0

Row {
    id: root
    width: section_list.width
           + section_indicator.width
           + section_content.width
           + spacing * 2
    height: 300
    spacing: 10

    // this property's deprecated, DPreferenceSectionList will adapt its size
    // accordingly, use sectionListMaxWidth to set a limit on its width.
    property int sectionListWidth: 200
    property int sectionListMaxWidth: 200

    property string currentSectionId
    property alias showActionButton: action_btn.visible
    property alias actionButtonText: action_btn.text

    default property alias content: col.children
    property alias sections: section_list.sections

    signal action()

    function changeIndicatorPos(pos) {
        section_indicator.pointerPos = pos + section_list.cellHeight / 2
    }

    function scrollTo(sectionId) { preference_content.scrollTo(sectionId) }

    signal anotherSectionCompleted ()

    onAnotherSectionCompleted: {
        indicate_first_timer.restart()
    }

    onCurrentSectionIdChanged: {
        if (!preference_content.flicking) scrollTo(currentSectionId)
    }

    DPreferenceSectionList {
        id: section_list
        height: root.height
        maxWidth: root.sectionListMaxWidth

        DTextAction {
            id: action_btn
            visible: false
            wrapMode: Text.WordWrap
            maxWidth: section_indicator.x - anchors.leftMargin
            leftRightMargin: 0
            topBottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            onClicked: root.action()
        }
    }

    DPreferenceSectionIndicator { id: section_indicator; height: root.height }

    Item {
        id: section_content
        clip: true
        width: 390
        height: root.height

        Flickable {
            id: preference_content
            anchors.fill: parent
            contentWidth: col.childrenRect.width
            contentHeight: col.childrenRect.height
            flickableDirection: Flickable.VerticalFlick

            Behavior on contentY {
                NumberAnimation { easing.type: Easing.InOutCubic; duration: 300 }
            }

            function scrollTo(sectionId) {
                var children = col.visibleChildren
                for (var i = 0; i < children.length; i++) {
                    if (children[i].sectionId == sectionId) {
                        contentY = children[i].y
                    }
                }
            }

            onContentYChanged: {
                if (!flicking) return

                if(atYEnd) {
                    root.currentSectionId = col.visibleChildren[col.visibleChildren.length - 1].sectionId
                } else {
                    var currentTopItem = col.childAt(50, contentY)
                    root.currentSectionId = currentTopItem ? currentTopItem.sectionId : col.visibleChildren[0].sectionId
                }
            }

            Timer {
                id: indicate_first_timer
                interval: 200
                onTriggered: {
                    root.currentSectionId = col.visibleChildren[0].sectionId
                }
            }

            Column {
                id: col
                width: preference_content.width
                height: root.height
            }
        }

        Rectangle {
            width: parent.width
            height: 4
            anchors.top: parent.top
            visible: preference_content.contentY != 0

            gradient: Gradient {
                GradientStop { position: 0.0; color: DPalette.contentBgColor }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Rectangle {
            width: parent.width
            height: 4
            anchors.bottom: parent.bottom

            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: DPalette.contentBgColor }
            }
        }
    }
}
