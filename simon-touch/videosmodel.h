#ifndef VIDEOSMODEL_H
#define VIDEOSMODEL_H

#include "flatfilesystemmodel.h"

class VideosModel : public FlatFilesystemModel
{
public:
    VideosModel(const QString& path);
};

#endif // VIDEOSMODEL_H
