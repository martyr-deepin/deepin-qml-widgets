import QtQuick 2.1
import QtQuick.Window 2.1
import Deepin.Widgets 1.0
import Deepin.Locale 1.0
import Qt.labs.folderlistmodel 2.1

Window {
    id: rootWindow
    flags: Qt.Dialog | Qt.FramelessWindowHint
    color: "transparent"
    width: frame.width
    height: frame.height
    property var dconstants: DConstants {}
    property var dssLocale: DLocale{
        domain: "deepin-qml-widgets"
    }

    function dsTr(s){
        return dssLocale.dsTr(s)
    }

    property alias folderModel: folderModel
    property alias showHidden: folderModel.showHidden
    property bool isVisible: false

    property int xPadding: 16
    property string currentFolder: "/"
    property bool isChooseFile: true

    signal selectAction(url fileUrl)
    signal cancelAction

    function showWindow(){
        isVisible = true
        show()
    }

    function hideWindow(){
        hide()
        isVisible = false
    }

    DFileChooseDialogAide {id:dfcdAide}

    DWindowFrame {
        id: frame
        width: 600 + (shadowRadius + frameRadius) * 2
        height: 350 + (shadowRadius + frameRadius) * 2

        MouseArea {
            anchors.fill: parent

            property int startX
            property int startY
            property bool holdFlag
            onPressed: {
                startX = mouse.x;
                startY = mouse.y;
                holdFlag = true;
            }
            onReleased: holdFlag = false;
            onPositionChanged: {
                if (holdFlag) {
                    rootWindow.setX(rootWindow.x + mouse.x - startX)
                    rootWindow.setY(rootWindow.y + mouse.y - startY)
                }
            }
        }

        Item {
            width: parent.width - 2
            height: parent.height - xPadding
            anchors.centerIn: parent
            clip: true

            Item {
                id: locationBox
                height: 25
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                DImageCheckButton {
                    id: goUpFolderButton
                    width: 24
                    height: 24
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    inactivatedNormalImage: "images/up_normal.png"
                    inactivatedHoverImage: "images/up_hover.png"
                    inactivatedPressImage: "images/up_press.png"

//                    activatedNormalImage: "images/delete_active.png"
//                    activatedHoverImage: "images/delete_active.png"
//                    activatedPressImage: "images/delete_active.png"

                    Behavior on opacity {
                        SmoothedAnimation { duration: 300 }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onPressed: parent.pressed = true
                        onReleased: { parent.pressed = false; parent.hovered = containsMouse; }
                        onClicked: rootWindow.currentFolder = rootWindow.currentFolder == "/"?"/":String(folderModel.parentFolder).slice(7)
                    }
                }

                DTextInput {
                    id:pathInput
                    anchors.left: goUpFolderButton.right
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    text: currentFolder

                    keyboardOperationsEnabled: false
                    onKeyPressed: {
                        if ((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return)){
                            if (dfcdAide.fileExist(text)){
                                pathInput.state = "normal"
                                if (dfcdAide.fileIsDir(text)){
                                    currentFolder = text
                                }
                                else{
                                    rootWindow.selectAction(text)
                                    rootWindow.hideWindow()
                                }
                            }
                            else{
                                print ("[Warning] file not exist...")
                                pathInput.state = "warning"
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: fileListViewBox
                anchors.top: locationBox.bottom
                anchors.topMargin: 10
                anchors.bottom: buttonBox.top
                anchors.bottomMargin: 10
                anchors.leftMargin: 2
                width: parent.width
                color: "#1f2021"
                border.width: 1
                border.color: dconstants.fgDarkColor
                clip: true

                ListView {
                    id: fileListView
                    anchors.fill: parent

                    FolderListModel {
                        id: folderModel
                        showDirsFirst: true
                        folder: currentFolder
                    }

                    Component {
                        id: fileDelegate
                        Rectangle {
                            color: index % 2 == 0 ? "#1f2021" : "#1d1e1f"
                            width: parent.width
                            height: 28

                            DSeparatorHorizontal {
                                anchors.top: parent.top
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width
                            }

                            DIcon {
                                id:fileIcon
                                anchors.left: parent.left
                                anchors.leftMargin: 6
                                anchors.verticalCenter: parent.verticalCenter

                                height: 24
                                width: 24
                                theme: "Deepin"
                                icon: dfcdAide.getIconName(filePath)
                            }

                            DLabel {
                                id:fileNameLabel
                                text: fileName;
                                color: folderModel.get(fileListView.currentIndex, "fileName") == fileName ?"#00bbfc" : "white"
                                anchors.left: fileIcon.right
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    parent.ListView.view.currentIndex = index
                                    console.log(index)
                                }
                                onDoubleClicked: {
                                    if(fileIsDir){
                                        rootWindow.currentFolder = filePath
                                        parent.ListView.view.currentIndex = -1
                                    }
                                    else{
                                        rootWindow.selectAction(filePath)
                                        rootWindow.hideWindow()
                                    }
                                }
                            }
                        }
                    }

                    model: folderModel
                    delegate: fileDelegate
//                    highlight: Rectangle{
//                        width: fileListView.width
//                        height: 30
//                        color: Qt.rgba(0, 189/255, 1, 0.5)
//                    }
                    highlightMoveDuration: 0

                    DScrollBar {
                        flickable: fileListView
                    }
                }
            }

            DSeparatorHorizontal {
                anchors.top: fileListViewBox.bottom
                width: parent.width
            }
            Row {
                id: buttonBox
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 15
                spacing: 10
                DTextButton {
                    text: dsTr("Cancel")
                    onClicked: {
                        rootWindow.hideWindow()
                        rootWindow.cancelAction()
                    }
                }
                DTextButton {
                    minMiddleWidth: 48
                    text: dsTr("OK")
                    onClicked: {
                        if(fileListView.currentIndex != -1){
                            if(isChooseFile && !folderModel.isFolder(fileListView.currentIndex)){
                                rootWindow.selectAction(folderModel.get(fileListView.currentIndex, "filePath"))
                                rootWindow.hideWindow()
                            }
                            else if(!isChooseFile && folderModel.isFolder(fileListView.currentIndex)){
                                rootWindow.selectAction(folderModel.get(fileListView.currentIndex, "filePath"))
                                rootWindow.hideWindow()
                            }
                        }
                    }
                }
            }

        }
    }
}

