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
    for (QHash<QString, QImage>::iterator i = m_images.begin(); i != m_images.end(); i++) {
        if (i.key().startsWith(groupId))
            m_images.remove(i.key());
    }
}

QImage ImageProvider::getImage(const QString& id) const
{
    return m_images.value(id);
}
