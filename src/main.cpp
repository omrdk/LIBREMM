#include <iostream>
#include <QApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>

#include "backoffice.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //qmlRegisterType<MetaData>("io.qt.metadata", 1, 0, "MetaData");

    QQmlApplicationEngine engine;



    //auto qmlPlayer = engine.rootObjects()[0]->findChild<QObject*>("qmlplayer");
    //QMediaPlayer* qmlplayer = qvariant_cast<QMediaPlayer*>(qmlPlayer->property("mediaObject")); // expose to C++

    BackOffice* boff = new BackOffice(nullptr);
    engine.rootContext()->setContextProperty("BackOffice", boff);
    engine.rootContext()->setContextProperty("PlaylistModal", boff->getPlaylist());  // expose to QML
    //std::unique_ptr<MetaData> str= std::make_unique<MetaData>();

    engine.load(QUrl(QStringLiteral("qrc:/mainpage.qml")));
    if (engine.rootObjects().isEmpty()) { return -1; }

    return app.exec(); 
}
