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
