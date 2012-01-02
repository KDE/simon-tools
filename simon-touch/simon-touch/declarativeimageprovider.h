#ifndef DECLARATIVEIMAGEPROVIDER_H
#define DECLARATIVEIMAGEPROVIDER_H

#include <QDeclarativeImageProvider>

class DeclarativeImageProvider : public QDeclarativeImageProvider
{
public:
    DeclarativeImageProvider();
    QImage requestImage(const QString & id, QSize * size, const QSize & requestedSize);
};

#endif // DECLARATIVEIMAGEPROVIDER_H
