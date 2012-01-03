#include "simontouchadapter.h"
#include "simontouch.h"

SimonTouchAdapter::SimonTouchAdapter(SimonTouch *parent)
    : QDBusAbstractAdaptor(parent)
{
    // constructor
    setAutoRelaySignals(true);
    connect(parent, SIGNAL(currentStatus(const QString&)), this, SLOT(relayStatus(const QString&)));
}

void SimonTouchAdapter::relayStatus(const QString& state)
{
    m_status = state;
    emit statusChanged();
}

QString SimonTouchAdapter::currentStatus()
{
    return m_status;
}
