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

Window {
	width: 500
	height: 300
	color: "transparent"
	x: 300
	y: 300
	flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.X11BypassWindowManagerHint

	DWindowFrame {
		anchors.fill: parent

	}
}
