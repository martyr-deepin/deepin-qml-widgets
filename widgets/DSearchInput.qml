import QtQuick 2.1

DTextInput {
    id: searchInput

    DConstants {id: dconstants}

    textInputRightMargin: clearImage.width
    textInputLeftMargin: searchImageBox.width

    property bool searchButtonPressable: false
    property string hintText: "Search"
    property bool inputActived: searchInput.text != "" || searchInput.focus

    Item {
        id: searchImageBox
        height: parent.height
        width: {
            if (inputActived)
                return searchImg.width
            else
                return searchImg.width + tipText.width + 4
        }

        state: inputActived ? "searchActived" : "searchNormal"
        
        DImageButton {
            id: searchImg
            transitionEnabled: true
            width: dconstants.imageButtonWidth
            height: searchInput.height
            normal_image: dconstants.imagesPath + "search_normal.png"
            hover_image: searchButtonPressable ? dconstants.imagesPath + "search_hover.png" : normal_image
            press_image: searchButtonPressable ? dconstants.imagesPath + "search_press.png" : normal_image

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: tipText
            visible: inputActived ? false : true
            height: parent.height
            width: inputActived ? 0 : contentWidth
            font.pixelSize: dconstants.fontSize
            color: dconstants.textHintColor
            text: hintText
            verticalAlignment:Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: searchImg.right
            anchors.leftMargin: 4
        }

        states:[
            State {
                name: "searchNormal"
                AnchorChanges { target: searchImageBox; anchors.left: undefined; anchors.horizontalCenter: searchInput.horizontalCenter}
            },
            State {
                name: "searchActived"
                AnchorChanges {target: searchImageBox; anchors.left: searchInput.left; anchors.horizontalCenter: undefined}
        }
        ]
        transitions: Transition {
            AnchorAnimation { duration: 200 }
        }
    }

    DImageButton {
        id: clearImage
        width: dconstants.imageButtonWidth
        height: parent.height
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        transitionEnabled: true
        visible: searchInput.text != ""
        normal_image: dconstants.imagesPath + "clear_content_normal.png"
        hover_image: dconstants.imagesPath + "clear_content_hover.png"
        press_image: dconstants.imagesPath + "clear_content_press.png"
        onClicked: {
            searchInput.text = ""
        }
    }
}
