#ifndef MAIL_H
#define MAIL_H

#include <akonadi/item.h>
#include <kmime/kmime_message.h>

class Mail
{

private:
    Akonadi::Item m_item;
    KMime::Message::Ptr m_msg;
public:
    Mail(Akonadi::Item item, KMime::Message::Ptr msg);
    bool getRead();
    void setRead();
    KMime::Message::Ptr getMessage() { return m_msg; }
};

#endif // MAIL_H
