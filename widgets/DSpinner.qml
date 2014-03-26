import QtQuick 2.0

Image {
    property alias model: view.model
    property alias delegate: view.delegate
    property alias currentIndex: view.currentIndex
    property real itemHeight: 30
    property int tempStep: 0

    clip: true

    PathView {
        id: view
        anchors.fill: parent

        pathItemCount: height/itemHeight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlight: Image { source: "images/spinner-select.png"; width: view.width; height: itemHeight+4 }
        dragMargin: view.width/2

        path: Path {
            startX: view.width/2; startY: -itemHeight/2
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
        }
    }

    Keys.onDownPressed: view.decrementCurrentIndex()
    Keys.onUpPressed: view.incrementCurrentIndex()

    Timer{
        id: moveTimer
        repeat: false
        running: false
        interval: 50
        onTriggered: {
            var index = (view.currentIndex + tempStep) % view.count
            if(index > 0){
                view.currentIndex = index
            }
            else{
                view.currentIndex = view.count + index
            }
            tempStep = 0
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onWheel: {
            if (wheel.angleDelta.y < 0){
                tempStep -= 1
            }
            else {
                tempStep += 1
            }
            moveTimer.restart()
        }
    }
}
