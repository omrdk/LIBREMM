import QtQuick 2.12
import QtMultimedia 5.12

Rectangle {

    width: parent.width; height: 75
    color: "transparent"
    anchors {
        left: parent.left; right: parent.right; bottom: parent.bottom
        leftMargin: 10; rightMargin: 10; bottomMargin: 10
    }

    property Image playimage: playimage                 // expose op, for image swapping
    property Rectangle volumepercent: volumepercent


//    Rectangle {
//        id: volume
//        y:backward.y
//        width: 40; height: 40
//        color: "gray"; radius: 10
//        //scale: 4/5
//        anchors { left: parent.left; top: parent.top; topMargin: 15; leftMargin: 5 }

//        Rectangle {
//            id: volumepercent
//            height: parent.height; width: 0
//            color: "yellow"; radius: 10
//            NumberAnimation on width { id: volumeper_up; from: 0; to: mmplayer.player.volume * 200; duration: 500; running: false }
//            NumberAnimation on width { id: volumeper_dw; from: mmplayer.player.volume * 200; to: 0; duration: 500; running: false }

//        }
//        MouseArea {
//            anchors.fill: parent
//            hoverEnabled: true
//            onEntered: {
//                volumeext_up.start();
//                volumeper_up.start();
//            }
//            onExited: {
//                volumeext_dw.start()
//                volumeper_dw.start()
//            }
//            onClicked: {
//                var mouseP = Qt.point(mouse.x, mouse.y);
//                var posnInVol = volumepercent.mapToItem(volume, mouseP)
//                volumepercent.width = posnInVol.x
//                mmplayer.player.volume = posnInVol.x / 200
//            }
//        }
//        NumberAnimation on width { id: volumeext_up; from: 40; to: 200; duration: 500; running: false }
//        NumberAnimation on width { id: volumeext_dw; from: 200; to: 40; duration: 500; running: false }
//        Image {
//            width: 40; height: 40
//            source: "qrc:/volume.png"
//            scale: 2/3
//        }
//    }

    Rectangle {
        id: backward
        width: 75; height: parent.height
        color: "transparent"
        anchors { right: play.left }
        Image {
            anchors.fill: parent
            source: "qrc:/backward.png"
            scale: 2/3
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mmplayer.player.seek(mmplayer.player.position - 10000)
                // -10 veya << işareti ekrana yansıtılsın
            }
        }
    }

    Rectangle {
        id: play
        width: 75; height: parent.height
        color: "transparent"; radius: 37.5
        anchors { horizontalCenter: parent.horizontalCenter }
        Image {
            id: playimage
            anchors.fill: parent
            source: "qrc:/play.png"
            scale: 2/3
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mmplayer.player.playbackState === MediaPlayer.PlayingState ? mmplayer.player.pause() : mmplayer.player.play()
            }
        }
    }

    Rectangle {
        id: forward
        width: 75; height: parent.height
        color: "transparent"
        anchors { left: play.right }
        Image {
            anchors.fill: parent
            source: "qrc:/forward.png"
            scale: 2/3
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mmplayer.player.seek(mmplayer.player.position + 10000)
                // +10 veya >> işareti ekrana yansıtılsın
            }
        }
    }

//    Rectangle {
//        id: subtitle
//        width: 40; height: 40
//        color: "white"; radius: 5
//        anchors { right: parent.right; top: parent.top; topMargin: 15; rightMargin: 5 }
//        Image {
//            anchors.fill: parent
//            source: "qrc:/subon.png"
//            //scale: 2/3
//        }
//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                subpopup.open()
//                //subpopup.open()
//            }
//        }
//    }

}


