#include "communicationcentral.h"

#include <kjob.h>

#include <akonadi/control.h>
#include <akonadi/collection.h>
#include <akonadi/monitor.h>
#include <akonadi/collectionfetchjob.h>
#include <akonadi/collectionfetchscope.h>
#include <akonadi/itemfetchjob.h>
#include <akonadi/itemfetchscope.h>

#include <kcalcore/incidence.h>
#include <kcalcore/event.h>



CommunicationCentral::CommunicationCentral(QObject *parent) : QObject(parent)
{
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
    //collectionsReceived(fetchJob->collections());
}

//akonadi stuff
void CommunicationCentral::test()
{
    qDebug() << "Akonadi test starting...";
    Akonadi::CollectionFetchJob *job = new Akonadi::CollectionFetchJob( Akonadi::Collection::root(),
                                                                        Akonadi::CollectionFetchJob::Recursive, 0 );

    connect(job, SIGNAL(finished(KJob*)), this, SLOT(collectionJobFinished(KJob*)));
    job->fetchScope().setContentMimeTypes(QStringList() << KCalCore::Event::eventMimeType());
}
