/*
 *   Copyright (C) 2008 Peter Grasch <grasch@simon-listens.org>
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

#ifndef SIMON_SKYPE_EXPORT_H_5D77B443FF0A456297DE6C3C3FEAC6F1
#define SIMON_SKYPE_EXPORT_H_5D77B443FF0A456297DE6C3C3FEAC6F1

// needed for KDE_EXPORT and KDE_IMPORT macros
#include <kdemacros.h>

#ifndef SKYPE_EXPORT
# if defined(MAKE_SKYPE_LIB)
// We are building this library
#  define SKYPE_EXPORT KDE_EXPORT
# else
// We are using this library
#  define SKYPE_EXPORT KDE_IMPORT
# endif
#endif

# ifndef SKYPE_EXPORT_DEPRECATED
#  define SKYPE_EXPORT_DEPRECATED KDE_DEPRECATED SKYPE_EXPORT
# endif
#endif
