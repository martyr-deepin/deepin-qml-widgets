/*************************************************************
*File Name: testDBaseExpand.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月23日 星期四 10时20分54秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    width: 200
    height: 400
    color: "yellow"

    DBaseExpand {
        id:testExpand
        width: parent.width * 4 / 5
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        header.sourceComponent: DArrowButton {
            direction:directionDown
            onClicked:{
                if (direction == directionDown){
                    direction = directionUp
                    testExpand.expanded = true
                }
                else{
                    direction = directionDown
                    testExpand.expanded = false
                }
            }
        }
        content.sourceComponent: Text {
            height: 200
            width: testExpand.width
            text: "Test text..."
            font.pixelSize: 15
        }
    }
}
