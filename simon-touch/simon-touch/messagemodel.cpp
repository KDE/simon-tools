#include "messagemodel.h"
#include "imageprovider.h"
#include <QDebug>
#include <KDE/KDateTime>

MessageModel::MessageModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "icon");
    names.insert(Qt::UserRole+2, "subject");
    names.insert(Qt::UserRole+3, "message");
    names.insert(Qt::UserRole+4, "datetime");
    setRoleNames(names);
}


void MessageModel::clear()
{
    m_messages.clear();
    ImageProvider::getInstance()->clearGroup("messages/");
}

void MessageModel::addItems(const QList<KMime::Message::Ptr>& items)
{
    m_messages.append(items);
    //qSort(m_messages);
    reset();
}


QVariant MessageModel::data(const QModelIndex& index, int role) const
{
    const KMime::Message::Ptr& msg = m_messages[index.row()];
    switch (role) {
    case Qt::UserRole: {
        return index.row();
    }
    case Qt::UserRole+1: { //icon
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
