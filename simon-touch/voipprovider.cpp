#include "voipprovider.h"

VoIPProvider::VoIPProvider()
{
    qRegisterMetaType<VoIPProvider::CallState>();
}
