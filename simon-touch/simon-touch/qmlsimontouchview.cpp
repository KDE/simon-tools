#include "qmlsimontouchview.h"
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"

QMLSimonTouchView::QMLSimonTouchView(ImagesModel *img, MusicModel *music, VideosModel *videos) :
    SimonTouchView(img, music,videos), viewer(QmlApplicationViewer::create())
{
    viewer->rootContext()->setContextProperty("imagesModel", img);
    viewer->rootContext()->setContextProperty("musicModel", music);
    viewer->rootContext()->setContextProperty("videosModel", videos);

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/simontouch/main.qml"));
    viewer->showExpanded();
}

QMLSimonTouchView::~QMLSimonTouchView()
{
}
