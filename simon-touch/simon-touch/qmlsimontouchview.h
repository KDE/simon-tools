#ifndef QMLSIMONTOUCHVIEW_H
#define QMLSIMONTOUCHVIEW_H

#include "simontouchview.h"
#include "qmlapplicationviewer.h"
#include <QScopedPointer>

class QMLSimonTouchView : public SimonTouchView
{
private:
    QScopedPointer<QmlApplicationViewer> viewer;

public:
    QMLSimonTouchView(ImagesModel *img, MusicModel *music, VideosModel *videos);
    ~QMLSimonTouchView();
};

#endif // QMLSIMONTOUCHVIEW_H
