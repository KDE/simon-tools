#include "communicationcentral.h"

#include <QStringList>

#include <kjob.h>

#include <akonadi/control.h>
#include <akonadi/collection.h>
#include <akonadi/monitor.h>
#include <akonadi/collectionfetchjob.h>
#include <akonadi/collectionfetchscope.h>
#include <akonadi/itemfetchjob.h>
#include <akonadi/itemfetchscope.h>

#include <kabc/addressee.h>
#include <kabc/contactgroup.h>



CommunicationCentral::CommunicationCentral(QObject *parent) : QObject(parent),
    m_contacts(new ContactsModel())
{
}

CommunicationCentral::~CommunicationCentral()
{
    delete m_contacts;
}

void CommunicationCentral::collectionJobFinished(KJob* job)
{
    qDebug() << "Got collections!";
    Akonadi::CollectionFetchJob *fetchJob = static_cast<Akonadi::CollectionFetchJob*>( job );
    qDebug() << "Cast' fetchJob!";
    if ( job->error() ) {
        qWarning() << job->errorString();
        return;
    }
    qDebug() << "Got " << fetchJob->collections().count() << " collections";


    m_contacts->clear();
    foreach (const Akonadi::Collection &collection, fetchJob->collections())
    {
      kDebug() << "Received collection: " << collection.name();
      Akonadi::ItemFetchJob *itemFetcher = new Akonadi::ItemFetchJob(collection, this);
      itemFetcher->fetchScope().fetchFullPayload();
      connect(itemFetcher, SIGNAL(finished(KJob*)), this, SLOT(itemJobFinished(KJob*)));
    }
}


void CommunicationCentral::itemJobFinished(KJob* job)
{
  Akonadi::ItemFetchJob *fetchJob = static_cast<Akonadi::ItemFetchJob*>( job );
  if ( job->error() ) {
      qWarning() << "Fetch job reported error: " << job->errorString();
      return;
  }

  if (fetchJob->items().isEmpty())
  {
    qWarning() << "Ignoring empty fetch result";
    return;
  }

  QList< KABC::Addressee > items;
  foreach (const Akonadi::Item& i, fetchJob->items())
  {
    KABC::Addressee contact;
    if (!i.isValid())
      continue;

    try
    {
      contact = i.payload< KABC::Addressee >();
    }
    catch (std::exception& e)
    {
      qWarning() << QString("Fetched contact group has wrong type and could not be deserialized (Payload: %1)").arg(QString::fromAscii(i.payloadData()));
      continue;
    }

    items.append(contact);
  }
  m_contacts->addItems(items);
}



void CommunicationCentral::setupCollections()
{
    qDebug() << "Akonadi test starting...";
    Akonadi::CollectionFetchJob *job = new Akonadi::CollectionFetchJob( Akonadi::Collection::root(),
                                                                        Akonadi::CollectionFetchJob::Recursive, 0 );

    connect(job, SIGNAL(finished(KJob*)), this, SLOT(collectionJobFinished(KJob*)));
    job->fetchScope().setContentMimeTypes(QStringList() << KABC::Addressee::mimeType());
}
