#ifndef VOIPPROVIDERFACTORY_H
#define VOIPPROVIDERFACTORY_H

class VoIPProvider;

class VoIPProviderFactory
{
public:
    static VoIPProvider* getProvider();
};

#endif // VOIPPROVIDERFACTORY_H
