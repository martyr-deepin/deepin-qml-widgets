/*************************************************************
*File Name: testDTextInput.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年05月14日 星期四 09时35分10秒
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
		spacing: 10
		DTextInput {
			text: "test1"
		}

		DTextInput {
			text: "fffffffffff"
			isPassword: true
		}

		DTextInput {
			text: "njewrenhwgre"
			showClearButton: true
		}
	}
}
