#include "configuration.h"
#include <KGlobal>
#include <KConfigGroup>
#include <KStandardDirs>
#include <KCmdLineArgs>

Configuration::Configuration()
{
    KCmdLineArgs *parsedArgs = KCmdLineArgs::parsedArgs();

    KConfigGroup information(KGlobal::config(), "information");

    if (parsedArgs->isSet("images"))
        m_imagePath = parsedArgs->getOption("images");
    else
        m_imagePath = information.readEntry("images", ".");

    if (parsedArgs->isSet("videos"))
        m_videosPath = parsedArgs->getOption("videos");
    else
        m_videosPath = information.readEntry("videos", ".");

    if (parsedArgs->isSet("music"))
        m_musicPath = parsedArgs->getOption("music");
    else
        m_musicPath = information.readEntry("music", ".");

    if (parsedArgs->isSet("feeds"))
        m_feeds = parsedArgs->getOption("feeds");
    else
        m_feeds = information.readEntry("feeds", ",,");

    KConfigGroup requests(KGlobal::config(), "requests");
    m_householdMailAddress = requests.readEntry("householdMailAddress", "");
    m_medicineMailAddress = requests.readEntry("medicineMailAddress", "");
    m_taxiNumber = requests.readEntry("taxiNumber", "");
    m_ambulanceNumber = requests.readEntry("ambulanceNumber", "");
    m_privateTransportNumber = requests.readEntry("privateTransportNumber", "");
    m_doctorNumber = requests.readEntry("doctorNumber", "");
    m_carerNumber = requests.readEntry("carerNumber", "");
    m_knownPersonNumber = requests.readEntry("knownPersonNumber", "");
}
