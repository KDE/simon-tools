#include <QtGui/QApplication>
#include <QtDBus/QDBusConnection>
#include "qmlsimontouchview.h"
#include "qmlapplicationviewer.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "rssfeeds.h"
#include "simontouch.h"
#include "simontouchadapter.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    if (app->arguments().count() < 5)
        qFatal("Call with: <path to images> <path to music> <path to videos> <feeds>");

    ImagesModel img(app->arguments()[1]);
    MusicModel music(app->arguments()[2]);
    VideosModel vids(app->arguments()[3]);
    QStringList feeds = app->arguments()[4].split(";");

    QStringList titles, urls, icons;
    foreach (const QString& feed, feeds) {
        QStringList details = feed.split(",");
        if (details.count() != 3)
            qFatal("Feed format: \"<title 1>,<url 1>,<icon 1>;<title 2>,...\"");
        titles << details[0];
        urls << details[1];
        icons << details[2];
    }

    RSSFeeds rssFeeds(titles, urls, icons);

    SimonTouch touch(&img, &music, &vids, &rssFeeds);

    new SimonTouchAdapter(&touch);
    QDBusConnection connection = QDBusConnection::sessionBus();
    connection.registerObject("/Main", &touch);
    connection.registerService("org.simon-listens.SimonTouch.Status");


    QMLSimonTouchView view(&touch);
    QObject::connect(&view, SIGNAL(enterState(SimonTouchState::State)), &touch, SLOT(enteredState(SimonTouchState::State)));

    touch.enteredState(SimonTouchState::Main);

    return app->exec();
}
