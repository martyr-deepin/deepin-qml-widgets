import QtQuick 2.1

Row {
    id: root
    width: 300
    height: 300
    spacing: 3

    property int sectionListWidth: 200
    property string currentSectionId
    property alias content: col
    property alias sections: section_list.sections

    DPreferenceSectionList {
        id: section_list
        width: root.sectionListWidth
        height: root.height

        onSectionSelected: {
            preference_content.scrollTo(currentSectionId)
        }
    }

    DPreferenceSectionIndicator { id: section_indicator; height: root.height}

    Item {
        clip: true
        width: root.width - section_list.width - section_indicator.width - root.spacing * 2
        height: root.height

        Flickable {
            id: preference_content
            anchors.fill: parent
            contentWidth: col.childrenRect.width
            contentHeight: col.childrenRect.height
            flickableDirection: Flickable.VerticalFlick

            function scrollTo(sectionId) {
                var children = col.visibleChildren
                for (var i = 0; i < children.length; i++) {
                    if (children[i].sectionId == sectionId) {
                        contentY = children[i].y
                    }
                }
            }

            onMovementEnded: {
                root.currentSectionId = col.childAt(contentX, contentY).sectionId
            }

            Column {
                id: col
                width: preference_content.width
                height: root.height
            }
        }
    }
}