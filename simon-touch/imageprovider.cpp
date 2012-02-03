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

#include "imageprovider.h"
#include <QDebug>

ImageProvider* ImageProvider::instance = 0;

ImageProvider::ImageProvider()
{
}

ImageProvider* ImageProvider::getInstance()
{
    if (!instance) instance = new ImageProvider;
    return instance;
}

void ImageProvider::registerImage(const QString& id, const QImage& image)
{
    qDebug() << "Registering image: " << id;
    m_images.insert(id, image);
}

void ImageProvider::removeImage(const QString& id)
{
    m_images.remove(id);
}

void ImageProvider::clearGroup(const QString& groupId)
{
    QMutableHashIterator<QString, QImage> i(m_images);
    while (i.hasNext()) {
        i.next();
        if (i.key().startsWith(groupId))
            i.remove();
    }
}

QImage ImageProvider::getImage(const QString& id) const
{
    return m_images.value(id);
}
