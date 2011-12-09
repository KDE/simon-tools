#include "messagemodel.h"
#include "imageprovider.h"
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
    ImageProvider::getInstance()->clearGroup("messages/");
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
