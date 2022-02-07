import QtQuick 2.12

DropArea {
    enabled: true

    onDropped: {

        drop.acceptProposedAction()
        if (drop.hasUrls)
        {
            if(drop.text.split('.').pop() === "srt") {  // get file extension
                toptools.settings.visible = true
                mmplayer.playingtrack.text = "Subtitle added  "
                subpath = drop.urls[0]
                BackOffice.readSub(drop.urls[0])
            }
            else {
                // append to listview
                for (let j=0; j < drop.urls.length; j++) {
                    j == 0 ? PlaylistModal.append(drop.urls[j], 1) : PlaylistModal.append(drop.urls[j], 0)
                }

                mmplayer.player.source = drop.urls[0]

            }
            mmplayer.playingtrackanm.running = true
        }
    }

}

