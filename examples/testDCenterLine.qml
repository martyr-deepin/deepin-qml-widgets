/*************************************************************
*File Name: testDCenterLine.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月23日 星期四 10时43分57秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    width: 500
    height: 500
    color: "yellow"

    DCenterLine {
        anchors.centerIn: parent
        title.text: "Title"
        title.verticalAlignment: Text.AlignVCenter
        content.sourceComponent: Rectangle {
            height: contentText.contentHeight
            width: contentText.contentWidth
            color: "red"
            Text {
                id:contentText
                text: "the content can be anything"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
