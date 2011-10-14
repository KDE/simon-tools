#include <QtGui/QApplication>
#include "qmlsimontouchview.h"
#include "qmlapplicationviewer.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "simontouch.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    ImagesModel img("/home/bedahr/Bilder/Wallpapers/");
    MusicModel music("/mnt/multimedia/Music/Florence And The Machine/Lungs (2009)/");
    VideosModel vids("/mnt/multimedia/Videos/other/");

    SimonTouch touch(&img, &music, &vids);
    QMLSimonTouchView view(&img, &music, &vids);

    return app->exec();
}
