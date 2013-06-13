/*
 *   Copyright (C) 2008-2011 Peter Grasch <grasch@simon-listens.org>
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

#ifndef SIMON_SIMONPROTOCOL_H_F0E4B83DBA554FB0A9D83585242F6E2B
#define SIMON_SIMONPROTOCOL_H_F0E4B83DBA554FB0A9D83585242F6E2B

namespace Simond
{
  enum Request
  {
    Login=1001,
    VersionIncompatible=1002,
    AuthenticationFailed=1003,
    AccessDenied=1004,
    LoginSuccessful=1005,

    RecognitionReady=4001,
    StartRecognition=4002,
    RecognitionError=4003,
    RecognitionWarning=4004,
    RecognitionStarted=4006,
    StopRecognition=4007,
    RecognitionStopped=4008,
    RecognitionResult=4013,

    RecognitionStartSample=4021,
    RecognitionSampleData=4022,
    RecognitionSampleFinished=4023
  };
}
#endif
