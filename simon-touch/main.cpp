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

#include <KApplication>
#include <KLocalizedString>
#include <KCmdLineArgs>
#include <KAboutData>
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
    KAboutData aboutData( "simon-touch", "simon-touch",
    			  ki18n("simon-touch"), "0.1",
    			  ki18n("Voice controlled media center and personal communication portal"),
			  KAboutData::License_GPL,
			  ki18n("Copyright (c) 2011-2012 Peter Grasch, Mathias Stieger") );

    KCmdLineOptions options;
    options.add("+images", ki18n("Path to images"));
    options.add("+music", ki18n("Path to music"));
    options.add("+videos", ki18n("Path to videos"));
    options.add("+feeds", ki18n("RSS feeds to use; Feed format: \"<title 1>,<url 1>,<icon 1>;<title 2>,..."));
    KCmdLineArgs::addCmdLineOptions(options);
    
    KCmdLineArgs::init(argc, argv, &aboutData);
    KApplication app;

    KGlobal::locale()->insertCatalog("libskype");

    if (KCmdLineArgs::parsedArgs()->count() < 4) {
    	qWarning() << i18n("Call with: <path to images> <path to music> <path to videos> <feeds>");
	return -1;
    }

    ImagesModel img(KCmdLineArgs::parsedArgs()->arg(0));
    MusicModel music(KCmdLineArgs::parsedArgs()->arg(1));
    VideosModel vids(KCmdLineArgs::parsedArgs()->arg(2));
    QStringList feeds = KCmdLineArgs::parsedArgs()->arg(3).split(';');

    QStringList titles, urls, icons;
    foreach (const QString& feed, feeds) {
        QStringList details = feed.split(',');
        if (details.count() != 3)  {
            qWarning() << i18n("RSS feed format: \"<title 1>,<url 1>,<icon 1>;<title 2>,...\"");
	    return -1;
	}
        titles << details[0];
        urls << details[1];
        icons << details[2];
    }

    RSSFeeds rssFeeds(titles, urls, icons);

    SimonTouch touch(&img, &music, &vids, &rssFeeds);

    new SimonTouchAdapter(&touch);
    QDBusConnection connection = QDBusConnection::sessionBus();
    connection.registerObject("/Main", &touch);
    connection.registerService("org.simon-listens.SimonTouch");


    QMLSimonTouchView view(&touch);
    QObject::connect(&view, SIGNAL(enterState(QString)), &touch, SLOT(enteredState(QString)));
    QObject::connect(&touch, SIGNAL(playVideo(QString)), &view, SLOT(playVideo(QString)));

    touch.enteredState("Main");

    return app.exec();
}
