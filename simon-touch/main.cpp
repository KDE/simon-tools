/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *   Copyright (C) 2012 Claus Zotter <claus.zotter@gmail.com>
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
#include "configuration.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "rssgroups.h"
#include "rssfeeds.h"
#include "simontouch.h"
#include "simontouchadapter.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    KAboutData aboutData( "simon-touch", "simon-touch",
    			  ki18n("simon-touch"), "0.1",
    			  ki18n("Voice controlled media center and personal communication portal"),
			  KAboutData::License_GPL,
              ki18n("Copyright (c) 2011-2012 Peter Grasch, Mathias Stieger, Claus Zotter") );

    KCmdLineOptions options;
    options.add("images <folder>", ki18n("Path to images"));
    options.add("music <folder>", ki18n("Path to music"));
    options.add("videos <folder>", ki18n("Path to videos"));
    options.add("feeds <description>", ki18n("RSS feeds to use; Feed format: \"<title 1>,<url 1>,<icon 1>,<group>;<title 2>,...\""));
    options.add("groups <description>", ki18n("RSS feed groups (e.g. different newspapers) to use; format: \"<grouphandle 1>,<groupname 1>,<groupicon 1>;<grouphandle 2>,...\""));
    KCmdLineArgs::addCmdLineOptions(options);
    
    KCmdLineArgs::init(argc, argv, &aboutData);
    KApplication app;

    KGlobal::locale()->insertCatalog("libskype");

    Configuration cfg;

    ImagesModel img(cfg.imagePath());
    MusicModel music(cfg.musicPath());
    VideosModel vids(cfg.videosPath());
    QStringList groups = cfg.groups().split(';');
    QStringList feeds = cfg.feeds().split(';');

    QStringList grouphandles, groupnames, groupicons;
    foreach (const QString& group, groups) {
        QStringList groupdetails = group.split(',');
        if (groupdetails.count() != 3) {
            qWarning() << i18n("RSS feed groups format: \"<grouphandle 1>,<groupname 1>,<groupicon 1>;<grouphandle 2>,...\"");
        return -1;
    }
        grouphandles << groupdetails[0];
        groupnames << groupdetails[1];
        groupicons << groupdetails[2];
    }

    QStringList titles, urls, icons, feedgroups;
    foreach (const QString& feed, feeds) {
        QStringList details = feed.split(',');
        if (details.count() != 4)  {
            qWarning() << i18n("RSS feed format: \"<title 1>,<url 1>,<icon 1>,<group>;<title 2>,...\"");
	    return -1;
	}
        titles << details[0];
        urls << details[1];
        icons << details[2];
        feedgroups << details[3];
    }

    RSSGroups rssGroups(grouphandles, groupnames, groupicons);

    RSSFeeds rssFeeds(titles, urls, icons, feedgroups);

    SimonTouch touch(&cfg, &img, &music, &vids, &rssFeeds, &rssGroups);

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
