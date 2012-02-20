/*
 * Copyright (c) 2012, simon listens e.V.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  * Neither the name of the organization nor the
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

#include "astrocam.h"
#include "astromobileadaptor.h"
#include <QNetworkAccessManager>
#include <QTimer>
#include <QDBusConnection>
#include <QNetworkRequest>
#include <KDebug>
#include <KProcess>
#include <KUrl>

Astrocam::Astrocam() : 
    m_vlc(new KProcess(this)),
    m_proxy(new KProcess(this)),
    m_protocolReader(new KProcess(this)),
    m_network(new QNetworkAccessManager(this)),
    m_refCount(0)
{
    kDebug() << "Registering service...";
    new AstrocamAdaptor(this);
    QDBusConnection dbus = QDBusConnection::systemBus();
    dbus.registerObject("/Astrocam", this);
    dbus.registerService("info.echord.Astromobile.Astrocam");
    
    kDebug() << "Starting proxy...";
    m_proxy->setProgram("tinyproxy", QStringList() << "-d");
    m_proxy->start();
    m_proxy->waitForStarted();
    
    kDebug() << "Starting VLC...";
    //vlc -I http --v4l2-width 640 --v4l2-height 480 -vvv --v4l2-fps 25 --no-sout-mp4-faststart --sout-asf-title "Astromobile" --vlm-conf vlm.conf --http-port 9090
    m_vlc->setProgram("vlc", QStringList() << "-I" << " http" << "--v4l2-width" << 
                      "640" << "--v4l2-height" << "480" << "--v4l2-fps" << 
                      "25" << "--no-sout-mp4-faststart" << "--sout-asf-title" << 
                      "\"Astromobile\"" << "--vlm-conf" << "vlm.conf" << 
                      "--http-port" << "9090" << "--http-host=0.0.0.0");
    m_vlc->start();
    m_vlc->waitForStarted();
    
    kDebug() << "Starting log watcher...";
    m_protocolReader->setOutputChannelMode(KProcess::OnlyStdoutChannel);
    
    m_protocolReader->setProgram("tail", QStringList() << "-f" << "/tmp/tinyproxy.log");
    m_protocolReader->start();
    m_protocolReader->waitForStarted();
    connect(m_protocolReader, SIGNAL(readyReadStandardOutput()), this, SLOT(protocolUpdated()));
    
    m_stopTimer.setSingleShot(true);
    m_stopTimer.setInterval(10000);
    connect(&m_stopTimer, SIGNAL(timeout()), this, SLOT(allClientsDisconnected()));
    
    kDebug() << "Setup completed";
}

void Astrocam::startRecordingToFile()
{
    kDebug() << "Starting to record to file";
    m_network->get(QNetworkRequest(KUrl("http://localhost:9090/requests/vlm_cmd.xml?command=control%20webcamfile%20play")));
}

void Astrocam::stopRecordingToFile()
{
    kDebug() << "Stopping recording to file";
    m_network->get(QNetworkRequest(KUrl("http://localhost:9090/requests/vlm_cmd.xml?command=control%20webcamfile%20stop")));
}

void Astrocam::startWebVideo()
{
    kDebug() << "Starting webcam video";
    m_network->get(QNetworkRequest(KUrl("http://localhost:9090/requests/vlm_cmd.xml?command=control%20webcam%20play")));
}

void Astrocam::stopWebVideo()
{
    kDebug() << "Stopping webcam video";
    m_network->get(QNetworkRequest(KUrl("http://localhost:9090/requests/vlm_cmd.xml?command=control%20webcam%20stop")));
}

void Astrocam::protocolUpdated()
{
  while (m_protocolReader->canReadLine()) {
    QByteArray line = m_protocolReader->readLine();
    if (line.contains("Established connection to upstream proxy")) {
      ++m_refCount;
      m_stopTimer.stop();
      kDebug() << "New client connected; We now have " << m_refCount << " active clients";
      continue;
    }
    if (line.contains("Closed connection") || line.contains("Error reading readble client_fd")) {
      m_refCount = qMax(0, m_refCount-1);
      if (m_refCount == 0)
        m_stopTimer.start();
      kDebug() << "Client disconnected; We now have " << m_refCount << " active clients";
    }
  }
}

void Astrocam::allClientsDisconnected()
{
  if (m_refCount > 0) return;

  stopWebVideo();
}