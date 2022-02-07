import QtQuick 2.12
import QtMultimedia 5.12
import QtQuick.Controls 2.12

Item {
    focus: true

    anchors.fill: parent

    Keys.onPressed: {
        // space play/pause - OK
        if(event.key === Qt.Key_Space) mmplayer.player.playbackState = MediaPlayer.PlayingState ? mmplayer.player.pause() : mmplayer.player.play();
        // Q quit - OK
        if(event.key === Qt.Key_Q) Qt.quit()
        // left -10s - OK
        if(event.key === Qt.Key_Left) {
            mmplayer.player.seek(mmplayer.player.position - 10000);

            mmplayer.playingtrackanm.running = false; mmplayer.playingtrackanm.running = true
            //timewraping.source = "qrc:/-10.png"
            //timewrap.opacity = 1; timewrap.visible = true; timewrapanm.running = false; timewrapanm.running = true
        }
        // right +10s - OK
        if(event.key === Qt.Key_Right) {
            mmplayer.player.seek(mmplayer.player.position + 10000);

            mmplayer.playingtrackanm.running = false; mmplayer.playingtrackanm.running = true
            //timewraping.source = "qrc:/+10.png"
            //timewrap.opacity = 1; timewrap.visible = true; timewrapanm.running = false; timewrapanm.running = true
        }
        // up volume +0.1 - OK
        if(event.key === Qt.Key_Up) {
            mmplayer.player.volume += 0.05; volumepbar.value = mmplayer.player.volume
            volumepopup.opacity = 1; volumepopup.visible = true; volpopanm.running = false; volpopanm.running = true;
        }
        // down volume -0.1 - OK
        if(event.key === Qt.Key_Down) {
            mmplayer.player.volume -= 0.05; volumepbar.value = mmplayer.player.volume
            volumepopup.opacity = 1; volumepopup.visible = true; volpopanm.running = false; volpopanm.running = true;
        }
        // enter fullscreen - OK
        if(event.key === Qt.Key_Return) frame.showFullScreen();
        // escape normalscreen - OK
        if(event.key === Qt.Key_Escape) frame.showNormal()
        // O open file - OK
        if(event.key === Qt.Key_O) toptools.openfile.visible = true
        // M mute
        if(event.key === Qt.Key_M) mmplayer.player.muted = mmplayer.player.muted ? false : true

        event.accepted = true;
    }

    Popup {
        id: volumepopup
        anchors.centerIn: parent
        visible: false
        modal: false
        width: 200; height: 200
        closePolicy: Popup.NoAutoClose
        background: Rectangle {
            anchors.fill: parent
            color: "lightgray"; radius: 5
        }
        NumberAnimation { id:volpopanm; target: volumepopup; property: "opacity"; from: 1.0; to: 0.0; running: false; duration: 1500 }

        Rectangle {
            width: parent.width*4/5; height: parent.height*4/5
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            Image {
                anchors.fill: parent
                source: "qrc:/volume"
            }
        }

        ProgressBar {
            id: volumepbar
            width: parent.width;
            anchors.bottom: parent.bottom
            value: mmplayer.player.volume
        }
    }

    Popup {
        id: timewrap
        anchors.centerIn: parent
        visible: false
        modal: false
        width: 200; height: 200
        closePolicy: Popup.NoAutoClose
        background: Rectangle {
            //anchors.fill: parent
            width: 150; height: 150
            anchors.centerIn: parent
            color: "white"; radius: width/2
            Image {
                id: timewraping
                anchors.fill: parent
                source: "qrc:/-10.png"
            }
        }
        NumberAnimation { id:timewrapanm; target: timewrap; property: "opacity"; from: 1.0; to: 0.0; running: false; duration: 1500 }
    }


    /// will be added

    // + faster
    // - slower
    // N next
    // P previous
    // H increase subtitle delay
    // G decrease sub delay
    // P preferences
    // H help
    // R random

}
