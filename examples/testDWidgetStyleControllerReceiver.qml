/*************************************************************
*File Name: testDWidgetStyleControllerReceiver.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月20日 星期一 16时57分17秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    id: mainRec
    width: 300
    height: 200
    color: dconstants.contentBgColor

    DConstants { id: dconstants }
    DWidgetStyleController {id: styleController}

    property var currentWidgetStyle: styleController.currentWidgetStyle

    onCurrentWidgetStyleChanged: {
        print ("CurrentWidget change...",currentWidgetStyle)
        if (currentWidgetStyle == DWidgetStyleController.StyleWhite)
            mainRec.color = "#ffffff"
        else
            mainRec.color = "dconstants.contentBgColor"
	}

}
