/*************************************************************
*File Name: testDWidgetDUIStyle.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月20日 星期一 14时16分24秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    width: 400
    height: 200
    color: dconstants.contentBgColor

	property var testList: dconstants.styleList
	onTestListChanged: {
		print ("============",testList)
	}

    DConstants { id: dconstants }

    Row {
        width: parent.width
        height: parent.height / 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 30

        Rectangle {
            color: dconstants.activeColor
            width: 100
            height: 20
            border.width: 0
            border.color: dconstants.tuhaoColor
            Text {
                id:whiteText
                text: "White Style"
                color: "#ffffff"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    print ("Change to white style...")
                    DUIStyle.setCurrentWidgetStyle("StyleWhite")
                }
                onEntered: parent.border.width = 2
                onExited: parent.border.width = 0
            }
        }

        Rectangle {
            color: dconstants.activeColor
            width: 100
            height: 20
            border.width: 0
            border.color: dconstants.tuhaoColor
            Text {
                text: "Black Style"
                color: "#ffffff"
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    print ("Change to black style...")
                    DUIStyle.setCurrentWidgetStyle("StyleBlack")
                }
                onEntered: parent.border.width = 2
                onExited: parent.border.width = 0
            }
        }
    }
}
