#ifndef COMMUNICATIONCENTRAL_H
#define COMMUNICATIONCENTRAL_H

#include <QObject>
#include "contactsmodel.h"

class KJob;

class CommunicationCentral : public QObject
{
    Q_OBJECT
private:
    ContactsModel *m_contacts;
    //MessageModel m_messageModel;

private slots:
    void collectionJobFinished(KJob* job);
    void itemJobFinished(KJob*);

public:
    CommunicationCentral(QObject *parent);
    ~CommunicationCentral();

    ContactsModel *getContacts() const { return m_contacts; }

public slots:
    void setupCollections();
};

#endif // COMMUNICATIONCENTRAL_H
