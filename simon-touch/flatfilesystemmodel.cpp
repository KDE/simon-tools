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

#include "flatfilesystemmodel.h"
#include <QDir>
#include <QHash>
#include <QDebug>

FlatFilesystemModel::FlatFilesystemModel(const QString& path, const QStringList& filters) : m_path(path)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "filePathRole");
    names.insert(Qt::UserRole+2, "niceFileName");
    setRoleNames(names);

    QDir d(path);
    m_files = d.entryList(filters, QDir::Files|QDir::NoDotAndDotDot);
}


int FlatFilesystemModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_files.count();
}

QVariant FlatFilesystemModel::data (const QModelIndex & index, int role) const
{
    if (role == Qt::UserRole)
        return index.row();
    if (role == Qt::UserRole+1)
        return m_path+QDir::separator()+m_files[index.row()];
    if (role == Qt::UserRole+2) {
        QString fileName = m_files[index.row()];
        return fileName.remove(QRegExp("\\.(^\\.)*$"));
    }
    return QVariant();
}

