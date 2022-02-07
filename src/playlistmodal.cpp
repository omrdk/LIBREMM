
#include "playlistmodal.h"

PlaylistModal::PlaylistModal(QObject *parent) : QAbstractListModel(parent)
{
}

int PlaylistModal::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_list.size();
}

QHash<int, QByteArray> PlaylistModal::roleNames() const {
    return { { NameRole,    "name"    },
             { PlayingRole, "playing" },
    };
}

void PlaylistModal::append(QString name, bool playing)
{
    int rowIndex = rowCount();
    beginInsertRows(QModelIndex(), rowIndex, rowIndex);
    TrackInfo track;
    track.name    = name; track.playing = playing;
    m_list.append(track);
    endInsertRows();
}

void PlaylistModal::remove(int i)
{
    beginRemoveRows(QModelIndex(), i, i);
    m_list.removeAt(i);
    endRemoveRows();
}

void PlaylistModal::clear()
{

}

QString PlaylistModal::getMediaUrl(int i)
{
    m_list[i].playing = true;
    return m_list[i].name;
}

QVariant PlaylistModal::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    if (!hasIndex(index.row(), index.column(), index.parent())) return QVariant();
    const TrackInfo &track = m_list.at(index.row());
    if (role == NameRole)   return track.name;
    if (role == PlayingRole)  return track.playing;
    return QVariant();
}

