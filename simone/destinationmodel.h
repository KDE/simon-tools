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

#ifndef CONTACTS_H
#define CONTACTS_H

#include "commandmodel.h"

class QStringList;
class Contacts : public CommandModel
{
Q_OBJECT

private:
    void setupRoleNames();

    void load(const QStringList& list);

public:
    Contacts();
    Contacts(const Contacts& other); //deep copy
    QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;

    void restore(const QStringList& config);
    QStringList store();

public slots:
    void removeContact(int index);
    void addContact();
    void updateContact(int index, const QString& trigger, const QString& displayName, const QString& number);
};

#endif // CONTACTS_H
