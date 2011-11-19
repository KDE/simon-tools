#ifndef COMMUNICATIONCENTRAL_H
#define COMMUNICATIONCENTRAL_H

#include <QObject>
#include <akonadi/collection.h>

class KJob;
class ContactsModel;
class MessageModel;
namespace Akonadi {
class Monitor;
}

class CommunicationCentral : public QObject
{
    Q_OBJECT
private:
    ContactsModel *m_contacts;
    MessageModel *m_messages;
    Akonadi::Monitor *m_collectionMonitor;
    Akonadi::Monitor *m_messageMonitor;
    Akonadi::Monitor *m_contactsMonitor;

    Akonadi::Collection::List m_messageCollections;
    Akonadi::Collection::List m_contactCollections;

    template <class T>
    QList<T> processItemJob(KJob*);

private slots:
    void contactCollectionJobFinished(KJob* job);
    void messageCollectionJobFinished(KJob* job);
    void contactItemJobFinished(KJob*);
    void messagesItemJobFinished(KJob*);

    void fetchContacts();
    void fetchMessages();

public:
    CommunicationCentral(QObject *parent);
    ~CommunicationCentral();

    ContactsModel *getContacts() const { return m_contacts; }
    MessageModel *getMessageModel() const { return m_messages; }

public slots:
    void setupCollections();

};

#endif // COMMUNICATIONCENTRAL_H
