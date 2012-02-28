#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QString>
#include <QObject>

class Configuration : public QObject
{
    Q_OBJECT
public:
    Configuration();

public slots:
    QString imagePath() { return m_imagePath; }
    QString musicPath() { return m_musicPath; }
    QString videosPath() { return m_videosPath; }
    QString feeds() { return m_feeds; }
    QString householdMailAddress() { return m_householdMailAddress; }
    QString medicineMailAddress() { return m_medicineMailAddress; }
    QString taxiNumber() { return m_taxiNumber; }
    QString ambulanceNumber() { return m_ambulanceNumber; }
    QString privateTransportNumber() { return m_privateTransportNumber; }
    QString doctorNumber() { return m_doctorNumber; }
    QString carerNumber() { return m_carerNumber; }
    QString knownPersonNumber() { return m_knownPersonNumber; }

private:
    QString m_imagePath;
    QString m_musicPath;
    QString m_videosPath;
    QString m_feeds;
    QString m_householdMailAddress;
    QString m_medicineMailAddress;
    QString m_taxiNumber;
    QString m_ambulanceNumber;
    QString m_privateTransportNumber;
    QString m_doctorNumber;
    QString m_carerNumber;
    QString m_knownPersonNumber;
};

#endif // CONFIGURATION_H
