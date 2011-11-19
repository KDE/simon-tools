#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <QAbstractListModel>
#include <kmime/kmime_message.h>

class MessageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MessageModel(QObject *parent = 0);
    void clear();
    void addItems(const QList<KMime::Message::Ptr>& items);

    virtual QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

private:
    QList< KMime::Message::Ptr > m_messages;
};

#endif // MESSAGEMODEL_H
