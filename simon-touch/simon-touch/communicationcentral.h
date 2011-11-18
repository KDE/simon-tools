#ifndef COMMUNICATIONCENTRAL_H
#define COMMUNICATIONCENTRAL_H

#include <QObject>

class KJob;

class CommunicationCentral : public QObject
{
    Q_OBJECT
private slots:
    void collectionJobFinished(KJob* job);

public:
    CommunicationCentral(QObject *parent);

public slots:
    void test();
};

#endif // COMMUNICATIONCENTRAL_H
