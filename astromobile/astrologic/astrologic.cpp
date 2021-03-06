/*
 * Copyright (c) 2011-2012, simon listens <office@simon-listens.org>
 * Copyright (c) 2011-2012, Scuola Superiore Sant�Anna <urp@sssup.it>
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  * Neither the name of the organizations nor the
 *  names of its contributors may be used to endorse or promote products
 *  derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "astrologic.h"
#include "astromobileadaptor.h"
#include <unistd.h>
#include <QApplication>
#include <QDomElement>
#include <QDomDocument>
#include <QCoreApplication>
#include <KDebug>
#include <KStandardDirs>
#include <KLocalizedString>

AstroLogic::AstroLogic()
{
    // Setting up service
    new AstroLogicAdaptor(this);
    QDBusConnection dbus = QDBusConnection::systemBus();
    dbus.registerObject("/AstroLogic", this);
    dbus.registerService("info.echord.Astromobile.AstroLogic");
    kDebug() << "Registered service...";
    // Done setting up service
    
    // Connecting to clients
    m_tts = new QDBusInterface("org.simon-listens.SimonTTS", "/SimonTTS", "local.SimonTTS", QDBusConnection::sessionBus());
    m_navigator = new QDBusInterface("info.echord.Astromobile.Navigator", "/Navigator", "info.echord.Astromobile.Navigator", QDBusConnection::systemBus());
    m_locator = new QDBusInterface("info.echord.Astromobile.Locator", "/Locator", "info.echord.Astromobile.Locator", QDBusConnection::systemBus());
    m_astrocam = new QDBusInterface("info.echord.Astromobile.Astrocam", "/Astrocam", "info.echord.Astromobile.Astrocam", QDBusConnection::systemBus());
    m_simontouch = new QDBusInterface("org.simon-listens.SimonTouch", "/Main", "local.SimonTouch", QDBusConnection::sessionBus());
    
    connect(m_astrocam, SIGNAL(broadcastingVideo()), this, SLOT(videoBroadcastStarted()));
    connect(m_astrocam, SIGNAL(recordingVideoToFile()), this, SLOT(videoRecordingToFileStarted()));
    connect(m_astrocam, SIGNAL(recordingStopped()), this, SLOT(videoRecordingStopped()));

    //initialization
    m_tts->call("initialize");

    //setting up locations
    setupLocations();
}

void AstroLogic::setupLocations()
{
    QFile f(KStandardDirs::locate("appdata", "locations.xml"));
    if (!f.open(QIODevice::ReadOnly)) {
      qWarning() << "Failed to read locations";
      return;
    }

    QDomDocument doc;
    doc.setContent(f.readAll());

    doc.documentElement();

    QDomElement locationElem = doc.documentElement().firstChildElement("location");
    while (!locationElem.isNull()) {
      QDomElement nameElem = locationElem.firstChildElement("name");
      QDomElement xElem = locationElem.firstChildElement("x");
      QDomElement yElem = locationElem.firstChildElement("y");
      QDomElement angleElem = locationElem.firstChildElement("angle");

      m_locations << new Location(nameElem.text(), xElem.text().toInt(), yElem.text().toInt(), angleElem.text().toInt());
      locationElem = locationElem.nextSiblingElement("location");
    }
}

void AstroLogic::videoBroadcastStarted()
{
    m_tts->call("say", i18n("Starting live video stream"));
}
void AstroLogic::videoRecordingStopped()
{
    m_tts->call("say", i18n("Stopped recording video"));
}
void AstroLogic::videoRecordingToFileStarted()
{
    m_tts->call("say", i18n("Starting to record surveillance video"));
}

//void AstroLogic::goToKitchen()
//{
    //kDebug() << "Going to the kitchen";
    //m_tts->call("say", i18n("Going to the kitchen"));
    //m_navigator->call("moveForward");
    //usleep(500000);
    //m_navigator->call("moveForward");
    //usleep(500000);
    //m_navigator->call("turnRight");
    //usleep(150000);
    //m_navigator->call("turnRight");
    //usleep(150000);
    //m_navigator->call("turnLeft");
    //usleep(150000);
    //m_navigator->call("turnLeft");
    //usleep(150000);
    //m_navigator->call("moveBackward");
    //usleep(500000);
    //m_navigator->call("moveBackward");
    //usleep(500000);
//}

void AstroLogic::startWebVideo()
{
    kDebug() << "Starting to stream video over web interface";
    m_astrocam->call("startWebVideo");
}

void AstroLogic::stopWebVideo()
{
    kDebug() << "Stopping streaming web video";
    m_astrocam->call("stopWebVideo");
}

QString AstroLogic::startRecordingToFile()
{
    kDebug() << "Starting to record a surveillance video";
    QDBusReply<QString> r = m_astrocam->call("startRecordingToFile");
    if (!r.isValid()) return QString();
    return r.value();
}

void AstroLogic::stopRecordingToFile()
{
    kDebug() << "Stopping surveillance video";
    m_astrocam->call("stopRecordingToFile");
}

bool AstroLogic::checkup(const QString& location)
{
  // 1. go to location using navigator
  navigateTo(location);
  
  // 2. start recording to file (astrocam)
  QString path = startRecordingToFile();
  
  // 3. look around
  lookAround();
  
  // 4. stop recording
  stopRecordingToFile();
  
  // 5. go back
  navigateTo("User2");

  // 6. tell ui to show video
  m_simontouch->call("playVideo", path);
  return true;
}

void AstroLogic::moveForward()
{
  m_navigator->call("moveForward");
}

void AstroLogic::moveBackward()
{
  m_navigator->call("moveBackward");
}

void AstroLogic::turnAround()
{
  for (int i = 0; i < 4; i++) {
    turnLeft();
    sleep(1);
  }
}

void AstroLogic::turnLeft()
{
  m_navigator->call("turnLeft");
}

void AstroLogic::turnRight()
{
  m_navigator->call("turnRight");
}


void AstroLogic::qsleep(int seconds)
{
  for (int i=1; i < seconds; i++) {
    sleep(1);
    QCoreApplication::processEvents();
  }
}

void AstroLogic::lookAround()
{
  qsleep(5);

  turnLeft();
  sleep(5);

  turnRight();
  sleep(5);

  turnRight();
  sleep(5);

  turnLeft();
  sleep(5);
}

bool AstroLogic::navigateTo(const QString& location)
{
  kDebug() << "Navigating to: " << location;
  Location *l = resolveLocation(location);
  if (!l)
    return false;
    
  m_navigator->call("goTo", l->destination().x(), l->destination().y(), l->angle());
  
  sleep(48);
  return true;
}

bool AstroLogic::navigateToUser()
{
  kDebug() << "Navigating to user";
  m_navigator->call("goToUser");
  
  return true;
}

Location* AstroLogic::resolveLocation(const QString& location)
{
  foreach (Location* l, m_locations) {
    if (l->name().compare(location, Qt::CaseInsensitive)==0) {
      return l;
    }
  }
  kDebug() << "Invalid location" << location;
  return 0;
}

QStringList AstroLogic::getLocations()
{
  QStringList locations;
  
  foreach (Location* l, m_locations)
    locations << l->name();

  return locations;
}

AstroLogic::~AstroLogic()
{
  qDeleteAll(m_locations);
}
