#include "mail.h"
#include <akonadi/itemmodifyjob.h>
#include <akonadi/kmime/messagestatus.h>
#include <akonadi/kmime/messageflags.h>
#include <Akonadi/ItemFetchJob>
#include <Akonadi/ItemFetchScope>
#include <kmime/kmime_message.h>

Mail::Mail(Akonadi::Item item, KMime::Message::Ptr msg) :
    QObject(),
    m_item(item), m_msg(msg), m_bodyFetched(false)
{
}

bool Mail::getRead()
{
    Akonadi::MessageStatus status;
    status.setStatusFromFlags(m_item.flags());
    return status.isRead();
}

void Mail::setRead()
{
    if (getRead())
        return;

    Akonadi::MessageStatus status;
    status.setStatusFromFlags(m_item.flags());
    status.setRead();
    m_item.setFlags(status.statusFlags());
    new Akonadi::ItemModifyJob(m_item); //store item
}


void Mail::fetchDetails(const Akonadi::Item& item)
{
    m_bodyFetched = true;

    QString subject;
    KMime::Headers::Subject *s = m_msg->subject();
    if (!s) subject = tr("No Subject");
    else subject = s->asUnicodeString();
    qDebug() << "Fetching details for " << subject;

    Akonadi::ItemFetchJob *job = new Akonadi::ItemFetchJob(item);
    connect(job, SIGNAL(result(KJob*)), SLOT(messageDetailJobFinished(KJob*)));
    job->fetchScope().fetchFullPayload();
}

void Mail::messageDetailJobFinished(KJob *job)
{
    qDebug() << "Got message details";
    if (job->error()) {
        qDebug() << "Error occurred" << job->errorString();
        return;
    }

    Akonadi::ItemFetchJob *fetchJob = qobject_cast<Akonadi::ItemFetchJob*>(job);

    const Akonadi::Item::List items = fetchJob->items();
    if (items.count() != 1) {
        qDebug() << "Unexpected item count: " << items.count();
        return;
    }

    m_item = items.first();
    try {
        m_msg = m_item.payload< KMime::Message::Ptr >();
    } catch (std::exception& e) {
        qWarning() << QString("Couldn't deserialize internal message! "+m_item.payloadData());
        return;
    }

    emit changed(this);
}

QString Mail::body()
{
    if (!m_bodyFetched) {
        //start fetching full item
        fetchDetails(m_item);
        return tr("Please wait...");
    }
    KMime::Content *c = m_msg->mainBodyPart();
    return c->decodedText(true,true);
}
