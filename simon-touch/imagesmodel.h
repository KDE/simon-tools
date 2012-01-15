#ifndef IMAGESMODEL_H
#define IMAGESMODEL_H

#include "flatfilesystemmodel.h"

class ImagesModel : public FlatFilesystemModel
{
    Q_OBJECT
public:
    ImagesModel(const QString& path);

};

#endif // IMAGESMODEL_H
