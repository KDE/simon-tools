#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <QAbstractListModel>
#include "mail.h"

class MessageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MessageModel(QObject *parent = 0);
    void clear();
    void addItems(const QList<Mail*>& items);

    virtual QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

    void readMessage(int messageIndex);
    ~MessageModel();

private slots:
    void changed(Mail* m);

private:
    QList< Mail* > m_messages;
};

#endif // MESSAGEMODEL_H
