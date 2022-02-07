#include <memory>

#include <QFile>
#include <QObject>
#include <QMediaPlayer>

#include "srtparser.h"
#include "iconv.hpp"
#include "playlistmodal.h"

#define VERSION 0.01

class BackOffice : public QObject
{
    Q_OBJECT
private:

    QMediaPlayer *player;

    PlaylistModal *m_playlist;

public:
    explicit BackOffice(QObject *parent = nullptr/*, QMediaPlayer* qmlplayer = nullptr*/);
    ~BackOffice();

    inline PlaylistModal *getPlaylist() { return m_playlist; }

public slots:
    Q_INVOKABLE void readSub(QString);
    Q_INVOKABLE void convCode(QString, QString, QString);

    QString getSubText(double);

private slots:

};
