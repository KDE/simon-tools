/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

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

    KABC::Addressee getContact(const QString& id);
    KABC::Addressee getContactBySkypeHandle(const QString& handle);

    QString getName(KABC::Addressee contact) const;
    QString getAvatar(KABC::Addressee contact) const;

private:
    QList< KABC::Addressee > m_contacts;

};

#endif // CONTACTSMODEL_H
