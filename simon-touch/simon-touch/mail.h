#ifndef MAIL_H
#define MAIL_H

#include <akonadi/item.h>
#include <kmime/kmime_message.h>

class KJob;

class Mail : public QObject
{
Q_OBJECT

signals:
    void changed(Mail*);

private:
    Akonadi::Item m_item;
    KMime::Message::Ptr m_msg;

    bool m_bodyFetched;

private slots:
    void fetchDetails(const Akonadi::Item& item);
    void messageDetailJobFinished(KJob *job);

public:
    Mail(Akonadi::Item item, KMime::Message::Ptr msg);
    bool getRead();
    void setRead();
    KMime::Message::Ptr getMessage() { return m_msg; }

    QString body();
};

#endif // MAIL_H
