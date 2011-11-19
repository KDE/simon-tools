#ifndef CONTACTSMODEL_H
#define CONTACTSMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QSharedPointer>
#include <kabc/addressee.h>

class QModelIndex;

class ContactsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ContactsModel(QObject *parent = 0);

    void clear();
    void addItems(const QList<KABC::Addressee>& items);

    virtual QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

private:
    QList< KABC::Addressee > m_contacts;

};

#endif // CONTACTSMODEL_H
