#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <akonadi/entitytreemodel.h>
#include <akonadi/collection.h>

namespace Akonadi {
class ChangeRecorder;
}
class KJob;

class MessageModel : public Akonadi::EntityTreeModel
{
Q_OBJECT
protected:
    int entityColumnCount(HeaderGroup headerGroup) const;
    QVariant entityHeaderData(int section, Qt::Orientation orientation, int role, HeaderGroup headerGroup) const;
    QVariant entityData(const Akonadi::Collection &collection, int column, int role) const;
    QVariant entityData(const Akonadi::Item &item, int column, int role) const;
    QVariant data(const QModelIndex& i, int role) const;

private slots:
    void fetchDetails(const Akonadi::Item& item) const;
    void messageDetailJobFinished(KJob *job);
public:
    MessageModel(Akonadi::ChangeRecorder* r);
    void readMessage(int messageIndex);
};

#endif // MESSAGEMODEL_H
