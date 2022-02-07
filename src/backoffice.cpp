#include <iconv.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "backoffice.h"

using namespace std;

std::vector<SubtitleItem*> sub;

BackOffice::BackOffice(QObject *parent/*, QMediaPlayer *qmlplayer*/)
{
    //player = qmlplayer;
    qDebug() << "LIBREMM Ver." << VERSION << "running";

    m_playlist = new PlaylistModal(this);   // no need to delete

}

BackOffice::~BackOffice()
{

}

void BackOffice::readSub(QString url)
{
    QString abs = url.mid(7); qDebug() << abs;
    SubtitleParserFactory *subParserFactory = new SubtitleParserFactory(abs.toStdString());
    SubtitleParser *parser = subParserFactory->getParser();
    sub = parser->getSubtitles();
}

auto BackOffice::getSubText(double pos_ms) -> QString
{
    QStringList textandtime;
    for(SubtitleItem *element : sub)
    {
        double T_START = element->getStartTime();
        double T_STOP  = element->getEndTime();

        if( (T_START <= pos_ms) && (pos_ms <= T_STOP))
        {
            return QString::fromStdString(element->getText());
        }
    }
    return "";
}

void BackOffice::convCode(QString path, QString TOCODE, QString FROMCODE)
{
    iconvpp::converter conv(TOCODE.toStdString(), FROMCODE.toStdString(), true, 1024);
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly)) { qDebug() << "Could not opened!"; return; }

    QByteArray ba;
    while (!file.atEnd())
    {
        ba += file.readLine();
    }
    file.close();

    std::string input = ba.toStdString();
    std::string output;

    conv.convert(input, output);
    QFile out(path);
    if(!out.open(QIODevice::Append)) { qDebug() << "Could not opened!"; return; }
    out.resize(0);
    out.write(output.c_str());
    out.close();
}





