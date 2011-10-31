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
    emit currentStatus((int) state);
}
