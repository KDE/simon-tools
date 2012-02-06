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

#include "messagemodel.h"
#include "imageprovider.h"
#include <QDebug>
#include <QImage>
#include <KDE/KDateTime>
#include <KIconLoader>
#include <KLocale>

MessageModel::MessageModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "index");
    names.insert(Qt::UserRole+1, "msgIcon");
    names.insert(Qt::UserRole+2, "subject");
    names.insert(Qt::UserRole+3, "message");
    names.insert(Qt::UserRole+4, "datetime");
    setRoleNames(names);


    ImageProvider::getInstance()->registerImage("mail/read",
                                                QImage(KIconLoader().iconPath("mail-read", -KIconLoader::SizeHuge, false)));
    ImageProvider::getInstance()->registerImage("mail/unread",
                                                QImage(KIconLoader().iconPath("mail-unread", -KIconLoader::SizeHuge, false)));
}

MessageModel::~MessageModel()
{
    ImageProvider::getInstance()->clearGroup("mail/");
}

void MessageModel::readMessage(int messageIndex)
{
    if (messageIndex >= m_messages.count())
        return;
    m_messages[messageIndex]->setRead();
}

void MessageModel::clear()
{
    qDeleteAll(m_messages);
    m_messages.clear();
    reset();
}

void MessageModel::addItems(const QList< Mail* >& items)
{
    m_messages.append(items);
    foreach (Mail *m, items)
        connect(m, SIGNAL(changed(Mail*)), this, SLOT(changed(Mail*)));
    //qSort(m_messages);
    reset();
}

void MessageModel::changed(Mail* m)
{
    int i = m_messages.indexOf(m);
    if (i == -1)
        return;

    emit dataChanged(index(i), index(i));
}

QVariant MessageModel::data(const QModelIndex& index, int role) const
{
    Mail* mail = m_messages[index.row()];
    const KMime::Message::Ptr& msg = mail->getMessage();
    switch (role) {
    case Qt::UserRole: {
        return index.row();
    }
    case Qt::UserRole+1: { //icon
        if (mail->getRead())
            return "image://images/mail/read";
        else
            return "image://images/mail/unread";
    }
    case Qt::UserRole+2: {
        KMime::Headers::Subject *s = msg->subject();
        if (!s) return i18n("No Subject");
        return s->asUnicodeString();
    }
    case Qt::UserRole+3: {
        QString body = mail->body();
        return body;
    }
    case Qt::UserRole+4: {
        return KGlobal::locale()->formatDateTime(msg->date()->dateTime().dateTime(), KLocale::FancyLongDate);
    }
    }

    return QVariant();
}

int MessageModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return m_messages.count();
}
