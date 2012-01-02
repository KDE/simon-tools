#include "imageprovider.h"
#include <QDebug>

ImageProvider* ImageProvider::instance = 0;

ImageProvider::ImageProvider()
{
}

ImageProvider* ImageProvider::getInstance()
{
    if (!instance) instance = new ImageProvider;
    return instance;
}

void ImageProvider::registerImage(const QString& id, const QImage& image)
{
    qDebug() << "Registering image: " << id;
    m_images.insert(id, image);
}

void ImageProvider::removeImage(const QString& id)
{
    m_images.remove(id);
}

void ImageProvider::clearGroup(const QString& groupId)
{
    QMutableHashIterator<QString, QImage> i(m_images);
    while (i.hasNext()) {
        i.next();
        if (i.key().startsWith(groupId))
            i.remove();
    }
}

QImage ImageProvider::getImage(const QString& id) const
{
    return m_images.value(id);
}
