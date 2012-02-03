/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

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
    QStringList feeds = app->arguments()[4].split(';');

    QStringList titles, urls, icons;
    foreach (const QString& feed, feeds) {
        QStringList details = feed.split(',');
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
    QObject::connect(&view, SIGNAL(enterState(QString)), &touch, SLOT(enteredState(QString)));

    touch.enteredState("Main");

    return app->exec();
}
