#ifndef COMMUNICATIONCENTRAL_H
#define COMMUNICATIONCENTRAL_H

#include <QObject>
#include <akonadi/collection.h>
#include <akonadi/item.h>
#include "voipprovider.h"

class KJob;
class ContactsModel;
class QTimer;
class MessageModel;
namespace Akonadi {
class Monitor;
}

class CommunicationCentral : public QObject
{
    Q_OBJECT

signals:
    void activeCall(const QString& user, const QString& avatar, bool ring);
    void callEnded();

public:
    CommunicationCentral(QObject *parent);
    ~CommunicationCentral();

    ContactsModel *getContacts() const { return m_contacts; }
    MessageModel *getMessageModel() const { return m_messages; }

    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void hangUp();
    void pickUp();
    void getMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);
    void readMessage(int messageIndex);

public slots:
    void setupContactCollections();


private:
    ContactsModel *m_contacts;
    MessageModel *m_messages;
    Akonadi::Monitor *m_collectionMonitor;
    Akonadi::Monitor *m_messageMonitor;
    Akonadi::Monitor *m_contactsMonitor;

    QString m_messageCollectionName;
    Akonadi::Collection m_messageCollection;
    Akonadi::Collection::List m_contactCollections;
    QTimer *m_mailChangedTimeout;

    VoIPProvider *m_voipProvider;

    QList<Akonadi::Item> getItemJobItems(KJob* job);
    template <class T>
    QList<T> processItemJob(KJob*);
    template <class T>
    bool createAndAddItem(QList<T>& items, Akonadi::Item);

private slots:
    void contactCollectionJobFinished(KJob* job);
    void messageCollectionSearchJobFinished(KJob* job);
    void messageCollectionCreateJobFinished(KJob* job);
    void contactItemJobFinished(KJob*);
    void messagesItemJobFinished(KJob*);

    void fetchContacts();
    void scheduleFetchMessages();
    void fetchMessages();

    QString getCurrentMessageUser();

    void emailSent(KJob* job);

    void handleCall(const QString& user, VoIPProvider::CallState state);
};

#endif // COMMUNICATIONCENTRAL_H
