import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.0

Popup {

    width: 250; height: 350
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    anchors.centerIn: Overlay.overlay

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 } }
    exit : Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 } }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"; radius: 5
        border { width: 2; color: "white" }
    }

    Column {

        anchors.fill: parent
        spacing: 5

        ComboBox {
            id: subonoff
            displayText: "Subtitle ON/OFF"
            width: parent.width; height: 50
            model: ["ON", "OFF"]
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }

            onActivated: {
                displayText = "Subtitle " + currentText
                switch(currentIndex)
                {
                    case 0: mmplayer.subtitle.visible = true; break;
                    case 1: mmplayer.subtitle.visible = false; break;
                }
            }
        }


        ComboBox {
            id: fontfamily
            displayText: "Font Family"
            width: parent.width; height: 50
            model: ["Bahnschrift", "Fantasque Sans Mono", "DejaVu Sans"]
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }
            onActivated: {
                displayText = "Font Family " + currentText
                mmplayer.subtitle.font.family = fontfamily.currentText
            }
        }

        ComboBox {
            id: fontsize
            displayText: "Font Size"
            width: parent.width; height: 50
            model: ["Smaller", "Small", "Normal", "Large", "Larger"]
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }
            onActivated: {
                displayText = "Font Size " + currentText
                switch(currentIndex)
                {
                    case 0: mmplayer.subtitle.font.pointSize = 30; break;
                    case 1: mmplayer.subtitle.font.pointSize = 40; break;
                    case 2: mmplayer.subtitle.font.pointSize = 50; break;
                    case 3: mmplayer.subtitle.font.pointSize = 60; break;
                    case 4: mmplayer.subtitle.font.pointSize = 70; break;
                }
            }
        }

        ComboBox {
            id: fontcolor
            displayText: "Font Color"
            width: parent.width; height: 50
            model: []
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    colorDialog.visible = true
                }
            }
            ColorDialog {
                id: colorDialog
                title: "Please choose a color"
                onAccepted: {
                    mmplayer.subtitle.color = colorDialog.color
                }
            }
        }

        ComboBox {
            id: pbackspeed
            displayText: "Playback Speed"
            width: parent.width; height: 50
            model: ["0.25", "0.5", "0.75", "1", "1.25", "1.5", "1.75", "2"]
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }

            onActivated: {
                displayText = "Playback Speed x" + currentText
                mmplayer.player.playbackRate = currentValue
            }
        }
        ComboBox {
            id: encoding
            displayText: "Encode Format"
            width: parent.width; height: 50
            model: ["ISO-8859-15", "CP1254", "UTF-8"]
            background: Rectangle {
                anchors.fill: parent
                //color: "transparent"
            }

            onActivated: {
                displayText = "Charset " + currentText
                subpath = subpath.substring(7)
                console.log(currentText)
                BackOffice.convCode(subpath, currentText, "")
                mmplayer.playingtrack.text = "Reload subtitle!  "
                mmplayer.playingtrackanm.running = true
            }
        }
    }


}


