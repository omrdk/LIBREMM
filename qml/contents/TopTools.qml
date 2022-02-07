import QtQuick 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    width: parent.width; height: 50
    color: "transparent"
    anchors {
        left: parent.left; right: parent.right; top: parent.top
        leftMargin: 10; rightMargin: 10; topMargin: 10
    }

    property FileDialog openfile: openfile
    property Rectangle settings: settings

    Rectangle {
        id: open
        width: 50; height: parent.height;
        color: "transparent"; radius: 10
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
        scale: 4/5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                openfile.visible = true
            }
        }
        Image {
            anchors.fill: parent
            source: "qrc:/openfile.png"
        }

        FileDialog {
            id: openfile
            nameFilters: [ "Video files (*.mp4 *.flv *.ts *.mpg *.3gp *.ogv *.m4v *.mov)", "All files (*)" ]
            title: "Please choose a video file"
            folder: shortcuts.movies
            selectMultiple: false
            sidebarVisible: true
            modality: Qt.WindowModal
            onAccepted: {
                //console.log("You chose: " + openfile.fileUrls)
                mmplayer.player.source = openfile.fileUrl
                //autoplay: true
                return
            }
            onRejected: {
                //console.log("Canceled")
                return
            }
        }
    }

    Rectangle {
        id: settings
        width: 50; height: parent.height;
        color: "transparent"
        visible: false
        anchors { horizontalCenter: parent.horizontalCenter }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                settingspopup.open()
            }
        }
        Image {
            anchors.fill: parent
            source: "qrc:/arrowdw.png"
        }
    }

    Rectangle {
        id: minimize
        width: 50; height: parent.height;
        color: "transparent"; radius: 25
        anchors { right: maximize.left; top: parent.top; bottom: parent.bottom }
        scale: 4/5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                frame.showMinimized()
            }
        }
        Image {
            id: minimage
            anchors.fill: parent
            source: "qrc:/minimize.png"
        }
    }

    Rectangle {
        id: maximize
        width: 50; height: parent.height;
        color: "transparent"; radius: 25
        anchors { right: close.left; top: parent.top; bottom: parent.bottom }
        scale: 3/4
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(!frame.fs) { showFullScreen(); frame.fs = 1; expimage.source = "qrc:/nscreen.png"; }
                else          { showNormal();     frame.fs = 0; expimage.source = "qrc:/fscreen.png"; }
            }
        }
        Image {
            id: expimage
            anchors.fill: parent
            source: "qrc:/fscreen.png"
        }
    }

    Rectangle {
        id: close
        width: 50; height: parent.height;
        color: "transparent"; radius: 25
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
        scale: 4/5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                frame.close()
            }
        }
        Image {
            anchors.fill: parent
            source: "qrc:/close.png"
        }
    }

}
