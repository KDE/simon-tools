#ifndef COMMUNICATIONCENTRAL_H
#define COMMUNICATIONCENTRAL_H

#include <QObject>
#include <akonadi/collection.h>

class KJob;
class ContactsModel;
class VoIPProvider;
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

    Akonadi::Collection m_messageCollection;
    Akonadi::Collection::List m_contactCollections;

    VoIPProvider *m_voipProvider;

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

    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void hangUp();
    void fetchMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);

public slots:
    void setupCollections();

};

#endif // COMMUNICATIONCENTRAL_H
