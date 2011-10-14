#include "musicmodel.h"
#include <QStringList>

MusicModel::MusicModel(const QString& path) :
    FlatFilesystemModel(path, QStringList() << "*.mp3")
{
}
