#include "simontouchadapter.h"
#include "simontouch.h"

SimonTouchAdapter::SimonTouchAdapter(SimonTouch *parent)
    : QDBusAbstractAdaptor(parent)
{
    // constructor
    setAutoRelaySignals(true);
    connect(parent, SIGNAL(currentStatus(SimonTouchState::State)), this, SLOT(relayStatus(SimonTouchState::State)));
}

void SimonTouchAdapter::relayStatus(SimonTouchState::State state)
{
    m_status = QString::number((int) state);
    emit statusChanged();
}

QString SimonTouchAdapter::currentStatus()
{
    return m_status;
}
