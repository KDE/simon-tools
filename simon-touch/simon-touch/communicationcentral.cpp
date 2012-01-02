#include "communicationcentral.h"
#include "contactsmodel.h"
#include "messagemodel.h"
#include "voipproviderfactory.h"
#include "voipprovider.h"

#include "mail.h"

#include <QStringList>
#include <QTimer>

#include <kjob.h>

#include <akonadi/control.h>
#include <akonadi/monitor.h>
#include <akonadi/collectionfetchjob.h>
#include <akonadi/collectionfetchscope.h>
#include <akonadi/searchcreatejob.h>
#include <akonadi/itemfetchjob.h>
#include <akonadi/itemfetchscope.h>
#include <akonadi/entitydisplayattribute.h>

#include <kmime/kmime_message.h>
#include <akonadi/kmime/messageparts.h>

#include <kabc/addressee.h>
#include <kabc/phonenumber.h>
#include <kabc/contactgroup.h>

#include <Nepomuk/Query/Query>
#include <Nepomuk/Query/Term>
#include <Nepomuk/Query/AndTerm>
#include <Nepomuk/Query/LiteralTerm>
#include <Nepomuk/Query/ResourceTypeTerm>
#include <Nepomuk/Query/ComparisonTerm>
#include <Nepomuk/Types/Literal>
#include <Nepomuk/Vocabulary/NMO>
#include <Nepomuk/Vocabulary/NCO>

CommunicationCentral::CommunicationCentral(QObject *parent) : QObject(parent),
    m_contacts(new ContactsModel()),
    m_messages(new MessageModel()),
    m_collectionMonitor(new Akonadi::Monitor(this)),
    m_messageMonitor(new Akonadi::Monitor(this)),
    m_contactsMonitor(new Akonadi::Monitor(this)),
    m_mailChangedTimeout(new QTimer(this)),
    m_voipProvider(VoIPProviderFactory::getProvider())
{
    m_collectionMonitor->setMimeTypeMonitored(KABC::Addressee::mimeType(), true);
    connect(m_collectionMonitor, SIGNAL(collectionAdded(Akonadi::Collection,Akonadi::Collection)), this, SLOT(setupContactCollections()));
    connect(m_collectionMonitor, SIGNAL(collectionChanged(Akonadi::Collection)), this, SLOT(setupContactCollections()));

    m_contactsMonitor->setMimeTypeMonitored(KABC::Addressee::mimeType(), true);
    connect(m_contactsMonitor, SIGNAL(itemAdded(Akonadi::Item,Akonadi::Collection)), this, SLOT(fetchContacts()));
    connect(m_contactsMonitor, SIGNAL(itemChanged(Akonadi::Item,QSet<QByteArray>)), this, SLOT(fetchContacts()));
    connect(m_contactsMonitor, SIGNAL(itemRemoved(Akonadi::Item)), this, SLOT(fetchContacts()));

    m_messageMonitor->setMimeTypeMonitored(KMime::Message::mimeType());
    connect(m_messageMonitor, SIGNAL(itemLinked(Akonadi::Item,Akonadi::Collection)), this, SLOT(scheduleFetchMessages()));
    m_mailChangedTimeout->setSingleShot(true);
    m_mailChangedTimeout->setInterval(500);
    connect(m_mailChangedTimeout, SIGNAL(timeout()), this, SLOT(fetchMessages()));
}

CommunicationCentral::~CommunicationCentral()
{
    delete m_contacts;
    delete m_messages;
    delete m_voipProvider;
}

void CommunicationCentral::setupContactCollections()
{
    m_contacts->clear();
    qDebug() << "Akonadi test starting...";
    Akonadi::CollectionFetchJob *job = new Akonadi::CollectionFetchJob( Akonadi::Collection::root(),
                                                                        Akonadi::CollectionFetchJob::Recursive, 0 );

    connect(job, SIGNAL(finished(KJob*)), this, SLOT(contactCollectionJobFinished(KJob*)));
    job->fetchScope().setContentMimeTypes(QStringList() << KABC::Addressee::mimeType());
}


void CommunicationCentral::contactCollectionJobFinished(KJob* job)
{
    Akonadi::CollectionFetchJob *fetchJob = static_cast<Akonadi::CollectionFetchJob*>( job );
    if ( job->error() ) {
        qWarning() << job->errorString();
        return;
    }

    m_contactCollections.clear();
    foreach (const Akonadi::Collection& c, fetchJob->collections())
        if (!c.name().startsWith("simontouch-"))
            m_contactCollections << c;
    fetchContacts();
}

void CommunicationCentral::fetchContacts()
{
    m_contacts->clear();
    foreach (const Akonadi::Collection &collection, m_contactCollections)
    {
      qDebug() << "Received collection: " << collection.name();
      Akonadi::ItemFetchJob *itemFetcher = new Akonadi::ItemFetchJob(collection, this);


      itemFetcher->fetchScope().fetchFullPayload();
      connect(itemFetcher, SIGNAL(finished(KJob*)), this, SLOT(contactItemJobFinished(KJob*)));
    }
}

QList<Akonadi::Item> CommunicationCentral::getItemJobItems(KJob* job)
{
    QList<Akonadi::Item> items;
    if ( job->error() ) {
        qWarning() << "Fetch job reported error: " << job->errorString();
        return items;
    }
    Akonadi::ItemFetchJob *fetchJob = static_cast<Akonadi::ItemFetchJob*>( job );

    if (fetchJob->items().isEmpty())
      qWarning() << "Empty fetch result";
    return fetchJob->items();
}

template <class T>
bool CommunicationCentral::createAndAddItem(QList<T>& items, Akonadi::Item i)
{
    T item;
    try {
        item = i.payload< T >();
    } catch (std::exception& e) {
        qWarning() << QString("Fetched item has wrong type and could not be deserialized (Payload: %1)").arg(QString::fromAscii(i.payloadData().left(2000)));
        return false;
    }
    items.append(item);
    return true;
}

template <>
bool CommunicationCentral::createAndAddItem(QList<Mail*>& items, Akonadi::Item i)
{
    KMime::Message::Ptr item;
    try {
        item = i.payload< KMime::Message::Ptr >();
    } catch (std::exception& e) {
        qWarning() << QString("Couldn't deserialize internal message! "+i.payloadData());
        return false;
    }
    items.append(new Mail(i, item));
    return true;
}

template <class T>
QList<T> CommunicationCentral::processItemJob(KJob* job)
{
    QList< T > items;
    QList<Akonadi::Item> genericItems = getItemJobItems(job);

    foreach (const Akonadi::Item& i, genericItems) {
      if (!i.isValid())
        continue;

      createAndAddItem<T>(items, i);
    }
    return items;
}

void CommunicationCentral::contactItemJobFinished(KJob* job)
{
  m_contacts->addItems(processItemJob<KABC::Addressee>(job));
}


void CommunicationCentral::debug()
{
    qDebug() << "Collection changed!";

}

QString CommunicationCentral::getCurrentMessageUser()
{
    QString name = m_messageCollectionName;
    name.remove(QRegExp("^simontouch-"));
    return name;
}

void CommunicationCentral::getMessages(const QString& user)
{
    if (m_contacts->getContact(user).emails().isEmpty())
        return;

    m_messages->clear();
    m_messageMonitor->setCollectionMonitored(m_messageCollection, false);
    m_messageCollectionName = "simontouch-"+user;
    qDebug() << "Fetching messages: " + m_messageCollectionName;

    Akonadi::CollectionFetchJob *job = new Akonadi::CollectionFetchJob( Akonadi::Collection::root(),
                                                                        Akonadi::CollectionFetchJob::Recursive, 0 );
    connect(job, SIGNAL(finished(KJob*)), this, SLOT(messageCollectionSearchJobFinished(KJob*)));
    job->fetchScope().setContentMimeTypes(QStringList() << KMime::Message::mimeType());
}

void CommunicationCentral::messageCollectionSearchJobFinished(KJob *job)
{
    Akonadi::CollectionFetchJob *fetchJob = static_cast<Akonadi::CollectionFetchJob*>( job );
    if ( job->error() ) {
        qWarning() << job->errorString();
        return;
    }
    foreach (const Akonadi::Collection &collection, fetchJob->collections())
    {
        //collection already exists - use that one
        if (collection.name() == m_messageCollectionName) {
            m_messageCollection = collection;
            fetchMessages();
            return;
        }
    }

    //else: search for messages
    QString emailStr = m_contacts->getContact(getCurrentMessageUser()).emails().first();

    Nepomuk::Query::ComparisonTerm valueTerm(Nepomuk::Vocabulary::NCO::emailAddress(), Nepomuk::Query::LiteralTerm(emailStr),
                                             Nepomuk::Query::ComparisonTerm::Equal);
    Nepomuk::Query::ComparisonTerm addressTerm(Nepomuk::Vocabulary::NCO::hasEmailAddress(), valueTerm,
                                             Nepomuk::Query::ComparisonTerm::Equal);

    Nepomuk::Query::ComparisonTerm personTerm(Nepomuk::Vocabulary::NMO::from(),
                                              addressTerm, Nepomuk::Query::ComparisonTerm::Equal);

    Nepomuk::Query::Query query(personTerm);
    qDebug() << "Executing sparql query: " << query.toSparqlQuery();

    Akonadi::SearchCreateJob *searchJob = new Akonadi::SearchCreateJob( m_messageCollectionName,
                                                                        query.toSparqlQuery() );
    connect(searchJob, SIGNAL(finished(KJob*)), this, SLOT(messageCollectionCreateJobFinished(KJob*)));
}

void CommunicationCentral::messageCollectionCreateJobFinished(KJob* job)
{
    if ( job->error() ) {
        qWarning() << job->errorString();
        return;
    }

    Akonadi::SearchCreateJob *fetchJob = static_cast<Akonadi::SearchCreateJob*>( job );
    qDebug() << "Created search folder successfully!";

    m_messageCollection = fetchJob->createdCollection();

    scheduleFetchMessages();
}

void CommunicationCentral::scheduleFetchMessages()
{
    m_mailChangedTimeout->stop();
    m_mailChangedTimeout->start();
}

void CommunicationCentral::fetchMessages()
{
    if (m_messageCollectionName.isEmpty())
        return;

    qDebug() << "Received collection: " << m_messageCollection.name();
    Akonadi::ItemFetchJob *itemFetcher = new Akonadi::ItemFetchJob(m_messageCollection, this);
    //itemFetcher->fetchScope().fetchFullPayload();
    itemFetcher->fetchScope().fetchPayloadPart(Akonadi::MessagePart::Envelope);
    //itemFetcher->fetchScope().fetchAttribute<Akonadi::EntityDisplayAttribute>();
    connect(itemFetcher, SIGNAL(finished(KJob*)), this, SLOT(messagesItemJobFinished(KJob*)));
    qDebug() << "Fetching payload";
}

void CommunicationCentral::messagesItemJobFinished(KJob* job)
{
    m_messages->clear();
    m_messages->addItems(processItemJob<Mail*>(job));
}



//-----------------------------------------------------------------------------
//                               SKYPE
//-----------------------------------------------------------------------------
void CommunicationCentral::callSkype(const QString& user)
{
    qDebug() << "Calling skype: " << user;

    m_voipProvider->newCall(m_contacts->getContact(user).custom("KADDRESSBOOK", "skype"));

}

void CommunicationCentral::callPhone(const QString& user)
{
    qDebug() << "Calling phone: " + user;
    m_voipProvider->newCall(m_contacts->getContact(user).phoneNumbers().first().number());
}

void CommunicationCentral::hangUp()
{
    m_voipProvider->hangUp();
}

void CommunicationCentral::sendSMS(const QString& user, const QString& message)
{
    qDebug() << "Sending SMS: " <<  user << message;
    m_voipProvider->sendSMS(m_contacts->getContact(user).phoneNumbers().first().number(), message);
}

void CommunicationCentral::sendMail(const QString& user, const QString& message)
{
    qDebug() << "Sending mail: " <<  user << message;
}

void CommunicationCentral::readMessage(int messageIndex)
{
    m_messages->readMessage(messageIndex);
}
