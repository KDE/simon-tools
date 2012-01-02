#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QImage>
#include <QHash>

class ImageProvider
{
public:
    static ImageProvider* getInstance();

    void registerImage(const QString& id, const QImage& image);
    void removeImage(const QString& id);
    void clearGroup(const QString& groupId);
    QImage getImage(const QString& id) const;

private:
    static ImageProvider* instance;

    QHash<QString /*id*/, QImage> m_images;
    ImageProvider();
};

#endif // IMAGEPROVIDER_H
