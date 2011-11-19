#include "contactsmodel.h"
#include <QDebug>

ContactsModel::ContactsModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void ContactsModel::clear()
{
    m_contacts.clear();
}

void ContactsModel::addItems(const QList<KABC::Addressee>& items)
{
    m_contacts.append(items);
    qSort(m_contacts);
    reset();
    /*foreach (const KABC::Addressee& ref, items) {
        qDebug() << ref.emails();
        qDebug() << ref.nickName();
        qDebug() << ref.givenName() << ref.familyName();

        //for (unsigned int i = 0; i < ref->count(); i++) {

            //qDebug() << "Contact group name: " << ref->data(0).name();
            //qDebug() << "Contact group mail: " << ref->data(0).email();
        //}

        //for (int i=0; i < items->count(); i++) {
        //    KABC::ContactGroup::ContactReference ref = items.contactReference(i);
        //
        //}
    }*/
}


QVariant ContactsModel::data(const QModelIndex& index, int role) const
{
    if (role == Qt::DisplayRole) {
        return m_contacts[index.row()].formattedName();
    }
    return QVariant();
}

int ContactsModel::rowCount(const QModelIndex& parent) const
{
    return m_contacts.count();
}
