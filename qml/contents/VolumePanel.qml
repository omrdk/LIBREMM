import QtQuick 2.12

Rectangle {
    y: parent.height/5
    width: parent.width/20; height: parent.height/3
    color: "transparent";
    anchors { left: parent.left; }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            show.running = true
        }

        onExited: {
            hide.running =true
        }
    }

    Rectangle {

        id: volumePopup;
        width: 0; height: parent.height
        color: "lightgray"; radius: 20

        SequentialAnimation {
            id: show; running: false
            NumberAnimation { target: volumePopup; property: "width"; to: 50; duration: 50 }
            //NumberAnimation { target: volumePopup; property: "height"; to: parent.height; duration: 50 }
            NumberAnimation { target: volumePopup; property: "x"; to: 10; easing.type: Easing.OutQuart; duration: 100 }
        }

        SequentialAnimation {
            id: hide; running: false
            NumberAnimation { target: volumePopup; property: "x"; to: 0; easing.type: Easing.OutQuart; duration: 100 }
            //NumberAnimation { target: volumePopup; property: "height"; to: 0; duration: 50 }
            NumberAnimation { target: volumePopup; property: "width"; to: 0; duration: 50 }
        }

        Rectangle {
            id: volumepercent
            anchors.bottom: parent.bottom;
            width: parent.width; height: mmplayer.player.volume * parent.height
            color: "yellow"; radius: 20

            // update volume & prevent oversize of height
            onHeightChanged: {
                mmplayer.player.volume = volumepercent.height / volumePopup.height
                if(height >= parent.height) { height = parent.height }
            }
        }

//        WheelHandler {
//            target: volumepercent
//            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
//            property: "height"
//        }

        Image {
            width: 40; height: 40
            source: "qrc:/volume.png"
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 10 }
            scale: 2/3
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                var mouseP = Qt.point(mouse.x, mouse.y);
                var posnInVol = volumepercent.mapToItem(volumePopup, mouseP)
                volumepercent.height = volumePopup.height - mouse.y
                mmplayer.player.volume = volumepercent.height / volumePopup.height
            }
        }

    }
}

