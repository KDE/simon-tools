#include "voipproviderfactory.h"
#include "skypevoipprovider.h"

VoIPProvider* VoIPProviderFactory::getProvider()
{
    return new SkypeVoIPProvider;
}
