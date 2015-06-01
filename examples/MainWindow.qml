/*************************************************************
*File Name: testDWindowFrame.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年05月15日 星期五 09时27分01秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import QtQuick.Window 2.1
import Deepin.Widgets 1.0

DWindow {
    id: rootWindow
	width: 800
	height: 500
	color: "transparent"
    flags: Qt.FramelessWindowHint

	DWindowFrame {
		anchors.fill: parent

        Item {
            id: titleArea
            width: parent.width
            height: 40

            DDragableArea{
                anchors.fill: parent
                window: rootWindow
            }

            Row {
                anchors.right: parent.right
                DTitleOptionButton{}
                DTitleMinimizeButton{}
                DTitleMaxUnmaxButton{}
                DTitleCloseButton{
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }

        Column {
            width: parent.width - 10
            anchors.top: titleArea.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5

            DArrowButton{}
            DCheckBox{
                text: "CheckBox"
            }
            DRadio{
                text: "Radio"
            }
        }
	}
}
