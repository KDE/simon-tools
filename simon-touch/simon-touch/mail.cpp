#include "mail.h"
#include <akonadi/itemmodifyjob.h>
#include <akonadi/kmime/messagestatus.h>
#include <akonadi/kmime/messageflags.h>
Mail::Mail(Akonadi::Item item, KMime::Message::Ptr msg) :
    m_item(item), m_msg(msg)
{
}

bool Mail::getRead()
{
    Akonadi::MessageStatus status;
    status.setStatusFromFlags(m_item.flags());
    return status.isRead();
}

void Mail::setRead()
{
    Akonadi::MessageStatus status;
    status.setStatusFromFlags(m_item.flags());
    status.setRead();
    m_item.setFlags(status.statusFlags());
    new Akonadi::ItemModifyJob(m_item); //store item
}
