#include "communicationcentral.h"
#include "contactsmodel.h"
#include "messagemodel.h"
#include "voipproviderfactory.h"
#include "voipprovider.h"

#include <QStringList>

#include <kjob.h>

#include <akonadi/control.h>
#include <akonadi/monitor.h>
#include <akonadi/collectionfetchjob.h>
#include <akonadi/collectionfetchscope.h>
#include <akonadi/searchcreatejob.h>
#include <akonadi/itemfetchjob.h>
#include <akonadi/itemfetchscope.h>

#include <kmime/kmime_message.h>

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
    m_voipProvider(VoIPProviderFactory::getProvider())
{
    m_collectionMonitor->setMimeTypeMonitored(KABC::Addressee::mimeType(), true);
    connect(m_collectionMonitor, SIGNAL(collectionAdded(Akonadi::Collection,Akonadi::Collection)), this, SLOT(setupCollections()));
    connect(m_collectionMonitor, SIGNAL(collectionChanged(Akonadi::Collection)), this, SLOT(setupCollections()));

    m_contactsMonitor->setMimeTypeMonitored(KABC::Addressee::mimeType(), true);
    connect(m_contactsMonitor, SIGNAL(itemAdded(Akonadi::Item,Akonadi::Collection)), this, SLOT(fetchContacts()));
    connect(m_contactsMonitor, SIGNAL(itemChanged(Akonadi::Item,QSet<QByteArray>)), this, SLOT(fetchContacts()));
    connect(m_contactsMonitor, SIGNAL(itemRemoved(Akonadi::Item)), this, SLOT(fetchContacts()));

    m_messageMonitor->setMimeTypeMonitored(KMime::Message::mimeType(), true);
    connect(m_messageMonitor, SIGNAL(itemAdded(Akonadi::Item,Akonadi::Collection)), this, SLOT(fetchMessages()));
    connect(m_messageMonitor, SIGNAL(itemChanged(Akonadi::Item,QSet<QByteArray>)), this, SLOT(fetchMessages()));
    connect(m_messageMonitor, SIGNAL(itemRemoved(Akonadi::Item)), this, SLOT(fetchMessages()));
}

CommunicationCentral::~CommunicationCentral()
{
    delete m_contacts;
    delete m_messages;
    delete m_voipProvider;
}

void CommunicationCentral::setupCollections()
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

    m_contactCollections = fetchJob->collections();
    fetchContacts();
}

void CommunicationCentral::fetchContacts()
{
    m_contacts->clear();
    foreach (const Akonadi::Collection &collection, m_contactCollections)
    {
      kDebug() << "Received collection: " << collection.name();
      Akonadi::ItemFetchJob *itemFetcher = new Akonadi::ItemFetchJob(collection, this);

      itemFetcher->fetchScope().fetchFullPayload();
      connect(itemFetcher, SIGNAL(finished(KJob*)), this, SLOT(contactItemJobFinished(KJob*)));
    }
}


template <class T>
QList<T> CommunicationCentral::processItemJob(KJob* job)
{
    QList< T > items;
    if ( job->error() ) {
        qWarning() << "Fetch job reported error: " << job->errorString();
        return items;
    }
    Akonadi::ItemFetchJob *fetchJob = static_cast<Akonadi::ItemFetchJob*>( job );

    if (fetchJob->items().isEmpty())
    {
      qWarning() << "Ignoring empty fetch result";
      return items;
    }

    foreach (const Akonadi::Item& i, fetchJob->items())
    {
      if (!i.isValid())
        continue;

      T item;
      try
      {
        item = i.payload< T >();
      }
      catch (std::exception& e)
      {
        qWarning() << QString("Fetched item has wrong type and could not be deserialized (Payload: %1)").arg(QString::fromAscii(i.payloadData().left(2000)));
        continue;
      }

      items.append(item);
    }
    return items;
}

void CommunicationCentral::contactItemJobFinished(KJob* job)
{
  m_contacts->addItems(processItemJob<KABC::Addressee>(job));
}


void CommunicationCentral::messageCollectionJobFinished(KJob* job)
{
    if ( job->error() ) {
        qWarning() << job->errorString();
        return;
    }

    Akonadi::SearchCreateJob *fetchJob = static_cast<Akonadi::SearchCreateJob*>( job );
    qDebug() << "Created search folder successfully!";
    m_messageCollection = fetchJob->createdCollection();
    m_messageMonitor->setCollectionMonitored(m_messageCollection, true);
    fetchMessages();
}

void CommunicationCentral::fetchMessages()
{
    m_messages->clear();

    kDebug() << "Received collection: " << m_messageCollection.name();
    Akonadi::ItemFetchJob *itemFetcher = new Akonadi::ItemFetchJob(m_messageCollection, this);
    itemFetcher->fetchScope().fetchFullPayload();
    connect(itemFetcher, SIGNAL(finished(KJob*)), this, SLOT(messagesItemJobFinished(KJob*)));
}

void CommunicationCentral::messagesItemJobFinished(KJob* job)
{
    m_messages->addItems(processItemJob<KMime::Message::Ptr>(job));
}

void CommunicationCentral::fetchMessages(const QString& user)
{
    m_messages->clear();
    qDebug() << "Fetching messages: " + user;

    QString emailStr = m_contacts->getContact(user).emails().first();

    Nepomuk::Query::ComparisonTerm valueTerm(Nepomuk::Vocabulary::NCO::emailAddress(), Nepomuk::Query::LiteralTerm(emailStr),
                                             Nepomuk::Query::ComparisonTerm::Equal);
    Nepomuk::Query::ComparisonTerm addressTerm(Nepomuk::Vocabulary::NCO::hasEmailAddress(), valueTerm,
                                             Nepomuk::Query::ComparisonTerm::Equal);

    Nepomuk::Query::ComparisonTerm personTerm(Nepomuk::Vocabulary::NMO::from(),
                                              addressTerm, Nepomuk::Query::ComparisonTerm::Equal);

    Nepomuk::Query::Query query(personTerm);
    qDebug() << "Executing sparql query: " << query.toSparqlQuery();

    Akonadi::SearchCreateJob *job = new Akonadi::SearchCreateJob( "simon-touch-"+user,
                                                                        query.toSparqlQuery() );
    connect(job, SIGNAL(finished(KJob*)), this, SLOT(messageCollectionJobFinished(KJob*)));
    //job->fetchScope().setContentMimeTypes(QStringList() << KMime::Message::mimeType());
}


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
