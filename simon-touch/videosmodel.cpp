#include "videosmodel.h"
#include <QStringList>

VideosModel::VideosModel(const QString& path) :
    FlatFilesystemModel(path, QStringList() << "*.avi" << "*.mkv" << "*.mp4" << "*.flv")
{
}
