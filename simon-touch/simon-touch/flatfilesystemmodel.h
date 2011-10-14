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
