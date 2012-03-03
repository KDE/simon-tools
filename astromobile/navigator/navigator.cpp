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

#include "navigator.h"
#include "astromobileadaptor.h"
#include <QApplication>
#include <QTimer>
#include <QDBusConnection>
#include <KDebug>

Navigator::Navigator(Blackboard *blackboard) : m_blackboard(blackboard)
{
    new NavigatorAdaptor(this);
    QDBusConnection dbus = QDBusConnection::systemBus();
    dbus.registerObject("/Navigator", this);
    dbus.registerService("info.echord.Astromobile.Navigator");
    kDebug() << "Registered service";

    Error tErr = getDataFromBlackboard<BlackboardDataVelocity>(m_blackboard, 
	     "MyRobot.VelocityCmd", m_velocityData);

    if (tErr != OK) {
	kWarning() << "FATAL: Failed to get the velocity data from the blackboard!\n";
        qApp->quit();
    }
}

void Navigator::test()
{
kWarning() << "This is a live demo";
}

void Navigator::goTo(int x, int y)
{
    //TODO
    kWarning() << "Moving to: " << x << y;
}

void Navigator::moveForward()
{
    m_velocityData->setVelocity(0.3, 0.0);
    m_velocityData->setModified();
}

void Navigator::moveBackward()
{
    m_velocityData->setVelocity(-0.3, 0.0);
    m_velocityData->setModified();
}

void Navigator::turnLeft()
{
    m_velocityData->setVelocity(0.0, 0.5);
    m_velocityData->setModified();
}

void Navigator::turnRight()
{
    m_velocityData->setVelocity(0.0, -0.5);
    m_velocityData->setModified();
}


void Navigator::quit()
{
     qApp->quit();
}

