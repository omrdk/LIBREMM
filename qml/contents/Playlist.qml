import QtQuick 2.0
import QtQml.Models 2.12

Item {
    y: parent.height/7
    width:frame.width/4; height: frame.height/1.5
    anchors.right: parent.right; anchors.rightMargin: 5

    property ListView listview: listview

    ListView {
        id: listview;
        anchors.fill: parent
        opacity: 0
        model: PlaylistModal
        delegate: delegatecom

        Rectangle {
            anchors.fill: parent
            color: "transparent";
            border { width: 1; color: "white" } radius: 10
        }

        SequentialAnimation {
            id: show; running: false
            NumberAnimation { target: listview; property: "opacity"; from:0; to: 0.75; duration: 500; }
        }

        SequentialAnimation {
            id: hide; running: false
            NumberAnimation { target: listview; property: "opacity"; from:0.75; to: 0; duration: 500 }
        }

        // delegate part
        Component {
            id: delegatecom

            Rectangle {
                id: delegatename
                implicitWidth: parent.width; implicitHeight: product_name.implicitHeight*3;
                color: "white"; radius: 10
                Text {
                    id: product_name; width: parent.width - parent.height
                    elide: Text.ElideLeft
                    text: model.name; color: "black"; font.pixelSize: 16;
                    anchors { verticalCenter: parent.verticalCenter; }
                }
                Image {
                    id: playingimg
                    width:  parent.height; height: parent.height
                    anchors.right: parent.right
                    source: model.playing ? "qrc:/pause.png" : "qrc:/play.png"
                    scale: 2/3
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        mmplayer.player.source = PlaylistModal.getMediaUrl(index)
                        // accessing grandchild of listitem (which is playingimg)
                        for(let i=0; i<listview.contentItem.children.length; i++) {
                            i === index ? listview.contentItem.children[i].children[1].source = "qrc:/pause.png" : listview.contentItem.children[i].children[1].source = "qrc:/play.png"
                        }
                        playingimg.source = model.playing ? "qrc:/pause.png" : "qrc:/play.png"

                    }
                    onHoveredChanged: {
                        containsMouse ? delegatename.color = "yellow" : delegatename.color = "white"
                        // keep playlist while listitem contains mouse
                        hide.running = containsMouse ? false : true
                    }
                }
            }
        }


    }

    // hover detection for show/hide playlist
    Rectangle {
        y: listview.y
        width: frame.width/30; height: parent.height
        anchors { right: parent.right; }
        color: "transparent";

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                show.running = true
                //console.log("entered")
            }

            onExited: {
                hide.running = true
                //console.log("exited")
            }
        }
    }






}
