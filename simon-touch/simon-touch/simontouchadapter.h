#ifndef SIMONTOUCHADAPTER_H
#define SIMONTOUCHADAPTER_H

#include <QtDBus/QtDBus>

class SimonTouch;

class SimonTouchAdapter : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "local.SimonTouch")
    Q_CLASSINFO("D-Bus Introspection", ""
                "<interface name=\"local.SimonTouch\">\n"
                "<signal name=\"statusChanged\" />\n"
                "<method name=\"currentStatus\">\n"
                   "<arg type=\"s\" direction=\"out\"/>\n"
                "</signal>\n"
                "</interface>\n"
                )
signals:
    void statusChanged();

private:
    QString m_status;

public:
    SimonTouchAdapter(SimonTouch *parent);

private slots:
    void relayStatus(const QString&);

public slots:
    QString currentStatus();
};

#endif // SIMONTOUCHADAPTER_H
