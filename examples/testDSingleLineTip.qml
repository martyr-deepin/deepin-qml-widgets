import QtQuick 2.1
import Deepin.Widgets 1.0

Rectangle {
	id: mainRec
	width:200
	height: 500

    property var singleLineTipComponent:Qt.createComponent("SingleLineTip.qml");
    property var singleLineTipPage;

	Component.onCompleted: {
		showTip(100,100,200,"This is a test...")
	}

    function showTip(x,y,width, toolTip)
    {
        singleLineTipPage = singleLineTipComponent.createObject(undefined);

        if (singleLineTipPage != undefined)
        {
            singleLineTipPage.x = x
            singleLineTipPage.y = y
            singleLineTipPage.width = width;
            singleLineTipPage.toolTip = toolTip
            singleLineTipPage.destroyInterval = 200
            singleLineTipPage.showTipAtTop()

            return
        }
        else
        {
            console.log("component createObject failed");
        }
    }


    function destroysingleLineTip()
    {
        if (singleLineTipPage != undefined)
            singleLineTipPage.destroyTip()
    }

    function destroysingleLineTipImmediately(){
        if (singleLineTipPage != undefined){
            singleLineTipPage.destroyInterval = -1
            singleLineTipPage.destroyTip()
        }
    }

}
