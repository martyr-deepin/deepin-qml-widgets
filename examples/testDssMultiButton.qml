/*************************************************************
*File Name: testDssMultiButton.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年05月11日 星期一 15时26分17秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
	width: 500
	height: 300
	color: "#fafafa"

	Column {
		anchors.fill: parent
		spacing: 10

		DssMultiAddCheckButton {}
		DssMultiAddCheckButton {}
		DssMultiAddCheckButton {}
		DssMultiAddCheckButton {}

		DssMultiDeleteButton {}
		DssMultiDeleteButton {}
		DssMultiDeleteButton {}
		DssMultiDeleteButton {}
	}
}
