#include "declarativeimageprovider.h"
#include "imageprovider.h"
#include <QDebug>

DeclarativeImageProvider::DeclarativeImageProvider() : QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{}

QImage DeclarativeImageProvider::requestImage(const QString & id, QSize * size, const QSize & requestedSize)
{
    qDebug() << "Requesting image: " + id;
    QImage img = ImageProvider::getInstance()->getImage(id);
    qDebug() << "Got image: " << img.isNull();
    *size = img.size();

    if (requestedSize.isValid())
        return img.scaled(requestedSize);
    else return img;
}
