#ifndef SIMONTOUCHADAPTER_H
#define SIMONTOUCHADAPTER_H

#include <QtDBus/QtDBus>
#include "simontouchstate.h"

class SimonTouch;

class SimonTouchAdapter : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "local.SimonTouch")
    Q_CLASSINFO("D-Bus Introspection", ""
                "<interface name=\"local.SimonTouch\">\n"
                        "<signal name=\"currentStatus\">\n"
                           "<arg name=\"status\" type=\"i\" direction=\"out\"/>\n"
                        "</signal>\n"
                "</interface>\n"
                )
signals:
    void currentStatus(int status);

public:
    SimonTouchAdapter(SimonTouch *parent);

private slots:
    void relayStatus(SimonTouchState::State);
};

#endif // SIMONTOUCHADAPTER_H
