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

#ifndef FLATFILESYSTEMMODEL_H
#define FLATFILESYSTEMMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class FlatFilesystemModel : public QAbstractListModel
{
    Q_OBJECT
private:
    QString m_path;
    QStringList m_files;

public:
    FlatFilesystemModel(const QString& path, const QStringList& filters);

    virtual QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;
    QModelIndex parent(const QModelIndex &child) const {
        Q_UNUSED(child);
        return QModelIndex();
    }
    int rowCount(const QModelIndex &parent=QModelIndex()) const;
};

#endif // FLATFILESYSTEMMODEL_H
