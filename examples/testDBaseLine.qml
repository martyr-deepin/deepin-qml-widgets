/*************************************************************
*File Name: testDBaseLine.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月23日 星期四 11时02分54秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    width: 500
    height: 500
    color: "yellow"

    DBaseLine {
        anchors.centerIn: parent
        leftLoader.sourceComponent: Rectangle {
            height: contentText.contentHeight
            width: contentText.contentWidth
            color: "red"
            Text {
                id:contentText
                text: "Left content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        rightLoader.sourceComponent: Rectangle {
            height: contentText2.contentHeight
            width: contentText2.contentWidth
            color: "red"
            Text {
                id:contentText2
                text: "Right content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}

