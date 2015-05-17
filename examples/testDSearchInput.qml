/*************************************************************
*File Name: testDSearchInput.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年05月14日 星期四 10时15分02秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
	width: 500
	height: 300
	color: "gray"

	Column {
		anchors.centerIn: parent
		spacing: 10

		DSearchInput{
			text: "ggggggggg"
		}
		DSearchInput{
			text: ""
		}
	}
}
