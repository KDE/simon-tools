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

#include "declarativeimageprovider.h"
#include "imageprovider.h"
#include <QDebug>

DeclarativeImageProvider::DeclarativeImageProvider() : QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{}

QImage DeclarativeImageProvider::requestImage(const QString & id, QSize * size, const QSize & requestedSize)
{
    qDebug() << "Requesting image: " + id;
    QImage img = ImageProvider::getInstance()->getImage(id);
    qDebug() << "Got image: " << img.isNull();
    *size = img.size();

    if (requestedSize.isValid())
        return img.scaled(requestedSize);
    else return img;
}
