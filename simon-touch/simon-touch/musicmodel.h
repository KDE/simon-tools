#ifndef MUSICMODEL_H
#define MUSICMODEL_H

#include "flatfilesystemmodel.h"

class MusicModel : public FlatFilesystemModel
{
public:
    MusicModel(const QString& path);
};

#endif // MUSICMODEL_H
