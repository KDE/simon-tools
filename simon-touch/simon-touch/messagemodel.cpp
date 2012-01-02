#include "messagemodel.h"
#include <Akonadi/ItemModifyJob>
#include <Akonadi/ItemFetchJob>
#include <Akonadi/ItemFetchScope>
#include <akonadi/kmime/messagestatus.h>
#include <akonadi/kmime/messageflags.h>
#include <kmime/kmime_message.h>
#include <KDE/KDateTime>
#include <KIconLoader>

MessageModel::MessageModel(Akonadi::ChangeRecorder* r) : Akonadi::EntityTreeModel(r)
{
    setCollectionFetchStrategy(EntityTreeModel::FetchNoCollections);
    setItemPopulationStrategy(EntityTreeModel::LazyPopulation);
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole+100, "index");
    names.insert(Qt::UserRole+101, "msgIcon");
    names.insert(Qt::UserRole+102, "subject");
    names.insert(Qt::UserRole+103, "message");
    names.insert(Qt::UserRole+104, "datetime");
    setRoleNames(names);
}

int MessageModel::entityColumnCount(HeaderGroup headerGroup) const
{
    if (headerGroup != ItemListHeaders)
        return 0;
    return 1;
}

QVariant MessageModel::entityHeaderData(int section, Qt::Orientation orientation, int role, HeaderGroup headerGroup) const
{
    Q_UNUSED(section);
    if ((headerGroup == ItemListHeaders) && (orientation == Qt::Horizontal) && (role == Qt::DisplayRole)) {
        return tr("Subject");
    }
    return QVariant();
}

QVariant MessageModel::entityData(const Akonadi::Collection &collection, int column, int role) const
{
    return EntityTreeModel::entityData(collection, column, role);
}

QVariant MessageModel::entityData(const Akonadi::Item &item, int column, int role) const
{
    KMime::Message::Ptr msg;
    try {
        msg = item.payload< KMime::Message::Ptr >();
    } catch (std::exception& e) {
        qWarning() << QString("Couldn't deserialize internal message! "+item.payloadData());
        return false;
    }

    switch(role) {
        case Qt::UserRole+101: {
            Akonadi::MessageStatus status;
            status.setStatusFromFlags(item.flags());
            if (status.isRead())
                return KIconLoader().iconPath("mail-read", -KIconLoader::SizeHuge, false);
            else
                return KIconLoader().iconPath("mail-unread", -KIconLoader::SizeHuge, false);
            break;
        }
        case Qt::UserRole+102: {
            KMime::Headers::Subject *s = msg->subject();
            if (!s) return tr("No Subject");
            return s->asUnicodeString();
        }
        case Qt::UserRole+103: {
            KMime::Content *c = msg->mainBodyPart();
            if (c->body().isEmpty()) {
                //start fetching full item
                qDebug() << "Lazy fetch...";
                fetchDetails(item);
                return tr("Please wait...");
            }
            qDebug() << "Body: " << c->body();
            return c->body();
        }
        case Qt::UserRole+104: {
            return msg->date()->dateTime().dateTime();
        }
    }
    return QVariant();
}

void MessageModel::fetchDetails(const Akonadi::Item& item) const
{
    Akonadi::ItemFetchJob *job = new Akonadi::ItemFetchJob(item);
    connect(job, SIGNAL(result(KJob*)), SLOT(messageDetailJobFinished(KJob*)));
    job->fetchScope().fetchFullPayload();
}

void MessageModel::messageDetailJobFinished(KJob *job)
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

    Akonadi::Item i = items.first();
    KMime::Message::Ptr msg;
    try {
        msg = i.payload< KMime::Message::Ptr >();
    } catch (std::exception& e) {
        qWarning() << QString("Couldn't deserialize internal message! "+i.payloadData());
        return;
    }


    //update internal item
    qDebug() << "New id: " << i.id();
    QModelIndexList indizes = modelIndexesForItem(this, i);

    foreach (const QModelIndex& index, indizes) {
        qDebug() << "Old index: " << index.row();

        QMap<int, QVariant> data = itemData(index);
        data.insert(Qt::UserRole+103, msg->mainBodyPart()->body());
        setItemData(index, data);
        //Akonadi::Item& oldItem = index.data(EntityTreeModel::ItemRole).value<Akonadi::Item>();
        //setItemData(index, , Qt::UserRole+103);


        //oldItem.setPayloadFromData(i.payloadData());

    }
}

void MessageModel::readMessage(int messageIndex)
{
    Akonadi::Item message = index(messageIndex, 0).data(EntityTreeModel::ItemRole).value<Akonadi::Item>();
    Akonadi::MessageStatus status;
    status.setStatusFromFlags(message.flags());
    status.setRead();
    message.setFlags(status.statusFlags());
    new Akonadi::ItemModifyJob(message); //store item
}

QVariant MessageModel::data(const QModelIndex& i, int role) const
{
    if (role == Qt::UserRole+100)
        return i.row();

    if (role == Qt::UserRole+103) {
        QMap<int, QVariant> data = itemData(i);
        if (data.contains(Qt::UserRole+103))
            return data.value(Qt::UserRole+103);
    }
    return Akonadi::EntityTreeModel::data(i, role);
}


/*
#include <QDebug>
#include <KDE/KDateTime>
#include <KIconLoader>

MessageModel::MessageModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "msgIcon");
    names.insert(Qt::UserRole+2, "subject");
    names.insert(Qt::UserRole+3, "message");
    names.insert(Qt::UserRole+4, "datetime");
    setRoleNames(names);
}

void MessageModel::readMessage(int messageIndex)
{
    if (messageIndex >= m_messages.count())
        return;
    m_messages[messageIndex]->setRead();
}

void MessageModel::clear()
{
    qDeleteAll(m_messages);
    m_messages.clear();
    reset();
}

void MessageModel::addItems(const QList< Mail* >& items)
{
    m_messages.append(items);
    //qSort(m_messages);
    reset();
}


QVariant MessageModel::data(const QModelIndex& index, int role) const
{
    Mail* mail = m_messages[index.row()];
    const KMime::Message::Ptr& msg = mail->getMessage();
    switch (role) {
    case Qt::UserRole: {
        return index.row();
    }
    case Qt::UserRole+1: { //icon
        qDebug() << "Icon path: " << KIconLoader().iconPath("mail-read", -KIconLoader::SizeHuge, false);
        if (mail->getRead())
            return KIconLoader().iconPath("mail-read", -KIconLoader::SizeHuge, false);
        else
            return KIconLoader().iconPath("mail-unread", -KIconLoader::SizeHuge, false);
        return QVariant();
    }
    case Qt::UserRole+2: {
        KMime::Headers::Subject *s = msg->subject();
        if (!s) return tr("No Subject");
        return s->asUnicodeString();
    }
    case Qt::UserRole+3: {
        KMime::Content *c = msg->mainBodyPart();
        return c->body();
    }
    case Qt::UserRole+4: {
        return msg->date()->dateTime().dateTime();
    }
    }

    return QVariant();
}

int MessageModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return m_messages.count();
}
*/
