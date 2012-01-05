#include "contactsmodel.h"
#include "imageprovider.h"
#include <QDebug>

ContactsModel::ContactsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "prettyName");
    names.insert(Qt::UserRole+2, "phoneNumber");
    names.insert(Qt::UserRole+3, "email");
    names.insert(Qt::UserRole+4, "skype");
    names.insert(Qt::UserRole+5, "image");
    names.insert(Qt::UserRole+6, "existingMessages");
    names.insert(Qt::UserRole+7, "uid");
    setRoleNames(names);
}

void ContactsModel::clear()
{
    m_contacts.clear();
    ImageProvider::getInstance()->clearGroup("contacts/");
}

void ContactsModel::addItems(const QList<KABC::Addressee>& items)
{
    m_contacts.append(items);
    qSort(m_contacts);
    reset();
}

KABC::Addressee ContactsModel::getContact(const QString& id)
{
    foreach (const KABC::Addressee& a, m_contacts)
        if (a.uid() == id)
            return a;
    return KABC::Addressee();
}

KABC::Addressee ContactsModel::getContactBySkypeHandle(const QString& handle)
{
    foreach (const KABC::Addressee& a, m_contacts) {
        if (a.custom("KADDRESSBOOK", "skype") == handle)
            return a;
    }

    return KABC::Addressee();
}


QString ContactsModel::getName(KABC::Addressee contact) const
{
    return contact.formattedName();
}

QString ContactsModel::getAvatar(KABC::Addressee contact) const
{
    KABC::Picture pic = contact.photo();
    qDebug() << "Picture url: " << pic.url();

    if (pic.isIntern()) {
        QString url = "contacts/"+contact.uid();
        ImageProvider::getInstance()->registerImage(url, pic.data());
        return "image://images/"+url;
    } else
        return pic.url();
}

QVariant ContactsModel::data(const QModelIndex& index, int role) const
{
    const KABC::Addressee& contact = m_contacts[index.row()];
    switch (role) {
    case Qt::UserRole: {
        return index.row();
    }
    case Qt::UserRole+1: {
        return getName(contact);
    }
    case Qt::UserRole+2: {
        KABC::PhoneNumber::List numbers = contact.phoneNumbers();
        if (numbers.empty())
            return "-";
        return numbers.first().number();
    }
    case Qt::UserRole+3: {
        QStringList mails = contact.emails();
        if (mails.empty())
            return "-";
        return mails.first();
    }
    case Qt::UserRole+4: {
        return contact.custom("KADDRESSBOOK", "skype");
    }
    case Qt::UserRole+5: {
        return getAvatar(contact);
    }
    case Qt::UserRole+6: {
        return true;
    }
    case Qt::UserRole+7: {
        return contact.uid();
    }
    }


    if (role == Qt::DisplayRole)
        return m_contacts[index.row()].formattedName();

    return QVariant();
}

int ContactsModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return m_contacts.count();
}
