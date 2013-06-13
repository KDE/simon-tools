/*
 *   Copyright (C) 2010 Peter Grasch <peter.grasch@bedahr.org>
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

#ifndef SIMON_SIMONSOUND_H_D0C0BA2429B04F65935956A32C79BB09
#define SIMON_SIMONSOUND_H_D0C0BA2429B04F65935956A32C79BB09

#include <QString>
#include <QMetaType>

namespace SimonSound
{
  enum State
  {
    IdleState=0,
    PreparedState=1,
    ActiveState=2
  };

  enum Error
  {
      NoError=0,
      OpenError=1,
      IOError=2,
      UnderrunError=3,
      FatalError=4,
      BackendBusy=5
  };

  enum SoundDeviceType
  {
    Input=1,
    Output=2
  };
}

Q_ENUMS(SimonSound::State);
Q_DECLARE_METATYPE(SimonSound::State);
Q_ENUMS(SimonSound::Error);
Q_DECLARE_METATYPE(SimonSound::Error);


#endif
