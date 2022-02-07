import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12

import "contents"


ApplicationWindow {
    id: frame;
    flags: Qt.FramelessWindowHint
    x: Screen.width/2 - width/2;
    y: Screen.height/2 - height/2
    width: 1280; height: 800;
    color: "transparent"
    visible: true;

    property int fs: 0
    property string subpath

    background: Rectangle {
        anchors.fill: parent
        color: "black"; radius: 25
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton// | Qt.RightButton
        property int prevX: 0
        property int prevY: 0
        onDoubleClicked: {
            if(!fs) { showFullScreen(); toptools.visible = false; fs = 1; opatmr.restart();  }
            else    { showNormal();     toptools.visible = true ; fs = 0; }
        }

        onPressed: {
            prevX = mouse.x; prevY = mouse.y
            toptools.opacity = 1
            slider.opacity = 1
            bottomtools.opacity = 1
            mmplayer.player.playbackState === MediaPlayer.PlayingState ? opatmr.restart() : opatmr.stop()
        }

        onPositionChanged:{
            var deltaX = mouse.x - prevX;
            frame.x += deltaX;
            prevX = mouse.x - deltaX;
            var deltaY = mouse.y - prevY
            frame.y += deltaY;
            prevY = mouse.y - deltaY;
        }


    }

    Timer {
        id: opatmr; running: false; interval: 3000; //repeat: true
        onTriggered: {
            topopa_dw.restart();
            sldopa_dw.restart();
            botopa_dw.restart();
        }
    }


    MMPlayer {
        id: mmplayer
        anchors.fill: parent

    }

    VolumePanel {
        id: volume

    }

    TopTools {
        id: toptools

        OpacityAnimator { id: topopa_up; target: toptools; from: 0; to: 1; duration: 500; running: true }
        OpacityAnimator { id: topopa_dw; target: toptools; from: 1; to: 0; duration: 3000; running: false }
    }

    Playlist {
        id:playlist

    }


    MediaDropArea {
        id: trackdrop
        anchors.fill: parent
    }


//    Rectangle {
//        y: parent.height/10
//        width: parent.width/30; height: parent.height/1.30
//        anchors { right: parent.right; }
//        color: "green";

//        MouseArea {
//            anchors.fill: parent
//            hoverEnabled: true

//            onEntered: {
//                //show.running = true
//                playlist.show.running = true
//                console.log("entered")
//            }

//            onExited: {
//                //hide.running =true
//                playlist.hide.running = true
//                console.log("exited")
//            }
//        }
//    }



    Slider {
        id: slider
        width: frame.width
        anchors { bottom: bottomtools.top }
        from: 0; to: mmplayer.player.duration
        onMoved: {
             mmplayer.player.seek(slider.value)
        }

        OpacityAnimator { id: sldopa_up; target: slider; from: 0; to: 1; duration: 500; running: true }
        OpacityAnimator { id: sldopa_dw; target: slider; from: 1; to: 0; duration: 3000; running: false }

    }

    BottomTools {
        id: bottomtools

        OpacityAnimator { id: botopa_up; target: bottomtools; from: 0; to: 1; duration: 500; running: true }
        OpacityAnimator { id: botopa_dw; target: bottomtools; from: 1; to: 0; duration: 3000; running: false }
    }

    Shortcuts {
        id: shortcuts
    }

    SubSettings {
        id: settingspopup
    }



}
