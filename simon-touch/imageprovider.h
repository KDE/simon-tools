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

#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QImage>
#include <QHash>

class ImageProvider
{
public:
    static ImageProvider* getInstance();

    void registerImage(const QString& id, const QImage& image);
    void removeImage(const QString& id);
    void clearGroup(const QString& groupId);
    QImage getImage(const QString& id) const;

private:
    static ImageProvider* instance;

    QHash<QString /*id*/, QImage> m_images;
    ImageProvider();
};

#endif // IMAGEPROVIDER_H
