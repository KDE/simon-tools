#include "imagesmodel.h"
#include <QStringList>

ImagesModel::ImagesModel(const QString& path) : FlatFilesystemModel(path, QStringList())
{
}
