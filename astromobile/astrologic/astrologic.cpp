/*
 * Copyright (c) 2011-2012, simon listens, Scuola Superiore Sant´Anna
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  * Neither the name of the <organization> nor the
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
#include <QApplication>
#include <unistd.h>
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
    
    connect(m_locator, SIGNAL(robotLocation(int, int, const QString&)), this, SLOT(processRobotLocation(int, int, const QString&)));
    
    connect(m_astrocam, SIGNAL(broadcastingVideo()), this, SLOT(videoBroadcastStarted()));
    connect(m_astrocam, SIGNAL(recordingVideoToFile()), this, SLOT(videoRecordingToFileStarted()));
    connect(m_astrocam, SIGNAL(recordingStopped()), this, SLOT(videoRecordingStopped()));

    //initialization
    m_tts->call("initialize");
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


void AstroLogic::processRobotLocation(int x, int y, const QString& text)
{
    kDebug() << "Received robot location: " << x << y << text;
    //TODO: Act on this information

    //re-publish info for ui
    emit robotLocation(x, y, text);
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

void AstroLogic::startRecordingToFile()
{
    kDebug() << "Starting to record a surveillance video";
    m_astrocam->call("startRecordingToFile");
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
  startRecordingToFile();
  
  // 3. wait a couple of seconds
  sleep(5);
  
  // 4. stop recording
  stopRecordingToFile();
  
  // 5. go back
  navigateTo(i18nc("user refers to the patient", "User"));

  // 6. TODO: tell ui to show video
  return true;
}

bool AstroLogic::navigateTo(const QString& location)
{
  kDebug() << "Navigating to: " << location;
  // 0. TODO: parse location to something the navigator understands
  // 1. TODO: tell navigator to go there
  return true;
}

QStringList AstroLogic::getLocations()
{
  //FIXME
  QStringList locations;
  locations << i18n("Kitchen");
  locations << i18n("Bedroom");
  locations << i18n("Bathroom");
  locations << i18nc("user refers to the patient", "User");

  return locations;
}

