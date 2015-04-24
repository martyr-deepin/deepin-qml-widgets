/*************************************************************
*File Name: testDssAdd_DeleteButton.qml
*Author: Match
*Email: Match.YangWanQing@gmail.com
*Created Time: 2015年04月23日 星期四 16时00分58秒
*Description:
*
*************************************************************/
import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
    width: 500
    height: 500
    color: "yellow"

    Row{
        DssAddCheckButton {}

        DssDeleteCheckButton {}
    }
}

