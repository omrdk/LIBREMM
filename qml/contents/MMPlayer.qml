import QtQuick 2.12
import QtMultimedia 5.12
import QtQuick.Controls 2.12


Item {
    id: mmitem

    property MediaPlayer player: player
    property Label subtitle: subtitle
    property Label playingtrack: playingtrack
    property NumberAnimation playingtrackanm: playingtrackanm


    MediaPlayer {
        id: player
        autoPlay: true
        volume: 0.5

        objectName: "qmlplayer"   // expose to C++

        onPlaying: {
            bottomtools.playimage.source = "qrc:/pause.png"
        }

        onPaused: {
            bottomtools.playimage.source = "qrc:/play.png"
        }

        onPositionChanged: {
            slider.value = position
        }


    }

    VideoOutput {
        anchors.fill: parent
        source: player
        visible: player.hasVideo



        Label {
            id: subtitle
            text: ""
            width: parent.width
            color: "yellow"
            font { family: "Bahnschrift"; pointSize: 60 }
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 150

            background: Rectangle {
                color: "transparent"
                anchors.left: parent.left
                anchors.right: parent.right
            }
            Timer {
                id: refreshTimer
                interval: 32  // 30Hz
                running: player.hasVideo
                repeat: true
                onTriggered: {
                   subtitle.text = BackOffice.getSubText(player.position)
                }
            }
        }

        Label {
            id: playingtrack
            width: parent.width
            color: "yellow"
            font { family: "Bahnschrift"; pointSize: 25 }
            horizontalAlignment: Text.AlignRight
            anchors.top: parent.top
            anchors.topMargin: 100;
            NumberAnimation { id: playingtrackanm; target: playingtrack; running: false; property: "opacity"; from: 1.0; to: 0.0; duration: 1500 }

            Timer {
                id: posMstoS
                interval: 750
                running: player.hasVideo
                repeat: true
                onTriggered: {
                    //playingtrack.text = Qt.formatTime(new Date(mmplayer.player.position), "hh:mm:ss")  // timezone?
                    playingtrack.text = mstoSec(mmplayer.player.position) + '/' + mstoSec(mmplayer.player.duration) + " "
                }

                function mstoSec(msec){
                    function pad(n, z) { z = z || 2; return ('00' + n).slice(-z); }
                    var s = msec
                    var ms = s % 1000;
                    s = (s - ms) / 1000;
                    var secs = s % 60;
                    s = (s - secs) / 60;
                    var mins = s % 60;
                    var hrs = (s - mins) / 60;
                    return pad(hrs) + ':' + pad(mins) + ':' + pad(secs);
                }
            }

        }



    }

}

