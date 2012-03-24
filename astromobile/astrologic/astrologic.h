/*
 * Copyright (c) 2011-2012, simon listens <office@simon-listens.org>
 * Copyright (c) 2011-2012, Scuola Superiore Sant´Anna <urp@sssup.it>
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

#ifndef ASTROLOGIC_h
#define ASTROLOGIC_h

#include <QObject>
#include <QDBusInterface>
#include <QStringList>
#include "location.h"

class AstroLogic : public QObject
{
Q_OBJECT
Q_CLASSINFO("AstroLogic", "info.echord.Astromobile.AstroLogic")

public slots:
    void startWebVideo();
    bool checkup(const QString& location);
    bool navigateTo(const QString& location);
    bool navigateToUser();

    void moveForward();
    void moveBackward();
    void turnLeft();
    void turnRight();
    void turnAround();

    void lookAround();
    
    QStringList getLocations();

public:
    AstroLogic();
    ~AstroLogic();
    
private:
    QDBusInterface *m_tts;
    QDBusInterface *m_navigator;
    QDBusInterface *m_locator;
    QDBusInterface *m_astrocam;
    QDBusInterface *m_simontouch;
    QList<Location*> m_locations;
    
    void stopWebVideo();
    
    QString startRecordingToFile();
    void stopRecordingToFile();
    Location* resolveLocation(const QString& location);
    void setupLocations();
    void qsleep(int seconds);

private slots:
    void videoBroadcastStarted();
    void videoRecordingToFileStarted();
    void videoRecordingStopped();
};

#endif
