#include "flatfilesystemmodel.h"
#include <QDir>
#include <QHash>
#include <QDebug>

FlatFilesystemModel::FlatFilesystemModel(const QString& path, const QStringList& filters) : m_path(path)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "filePathRole");
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
    return QVariant();
}

