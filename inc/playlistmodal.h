#ifndef PLAYLISTMODAL_H
#define PLAYLISTMODAL_H

#include <QDebug>
#include <QAbstractListModel>

struct TrackInfo
{
    QString name;
    bool playing;
};


class PlaylistModal : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit PlaylistModal(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void append(QString name, bool playing);

    Q_INVOKABLE void remove(int i);

    Q_INVOKABLE void clear();

    Q_INVOKABLE QString getMediaUrl(int i);





    QList<TrackInfo> m_list;

    enum TrackRoles {
        NameRole = Qt::UserRole + 1,
        PlayingRole
    };

    Q_ENUM(TrackRoles)

private:
};

#endif // PLAYLISTMODAL_H
