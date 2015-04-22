/*************************************************************
*File Name: SingleLineTip.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月15日 星期三 13时09分24秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

DSingleLineTip {
    width: 100
    height: 40
    radius:2
    textColor:"#000000"
    backgroundColor:"#ffffff"
	arrowWidth: 6
    arrowHeight: 9
	arrowLeftMargin: 20
    destroyInterval: 200
	borderColor: "#000fff"
    fontPixelSize: 8
	x:100
    y:500

    property alias animationEnable: yAnimation.enabled

    Behavior on y {
        id:yAnimation
        SmoothedAnimation {duration:  300}
    }
}

