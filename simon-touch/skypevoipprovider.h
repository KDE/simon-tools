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

#ifndef SKYPEVOIPPROVIDER_H
#define SKYPEVOIPPROVIDER_H

class Skype;

#include "voipprovider.h"
#include <QHash>

#ifdef Q_OS_LINUX
class QX11EmbedContainer;
#endif


class SkypeVoIPProvider : public VoIPProvider
{
    Q_OBJECT

public:
    SkypeVoIPProvider();
    ~SkypeVoIPProvider();
    void newCall(const QString& userId);
    void hangUp();
    void pickUp();
    void sendSMS(const QString& userId, const QString& message);
    QWidget *videoWidget();

private:
    QHash<QString /*callId*/, QString /*user*/> calls;
    Skype *s;
    bool dropVoiceMail;

#ifdef Q_OS_LINUX
    QX11EmbedContainer *videoContainer;
#endif

private slots:
    void voiceMailActive(int id);
    void voiceMessageSent();

    void newCall(const QString& callId, const QString& userId);
    void callStatus(const QString& callId, const QString& status);

    void processVideo();
    void realVideoProcessing();

    void startVideoStream();
};

#endif // SKYPEVOIPPROVIDER_H
