# Add more folders to ship with the application, here
folder_01.source = qml/simontouch
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += xml dbus network

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility qdbus dbusadaptors plugin
MOBILITY += multimedia

SOURCES += main.cpp \
    simontouchview.cpp \
    qmlsimontouchview.cpp \
    simontouch.cpp \
    imagesmodel.cpp \
    videosmodel.cpp \
    musicmodel.cpp \
    flatfilesystemmodel.cpp \
    rssfeeds.cpp \
    rssfeed.cpp \
    simontouchadapter.cpp \
    communicationcentral.cpp \
    contactsmodel.cpp \
    messagemodel.cpp \
    imageprovider.cpp \
    declarativeimageprovider.cpp \
    voipprovider.cpp \
    voipproviderfactory.cpp \
    skypevoipprovider.cpp \
    mail.cpp \
    configuration.cpp


# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

INCLUDEPATH += /usr/include/KDE


TRANSLATIONS = messages/simontouch_de.ts

HEADERS += \
    simontouchview.h \
    qmlsimontouchview.h \
    simontouch.h \
    imagesmodel.h \
    videosmodel.h \
    musicmodel.h \
    flatfilesystemmodel.h \
    rssfeeds.h \
    rssfeed.h \
    simontouchadapter.h \
    communicationcentral.h \
    contactsmodel.h \
    messagemodel.h \
    imageprovider.h \
    declarativeimageprovider.h \
    voipprovider.h \
    voipproviderfactory.h \
    skypevoipprovider.h \
    mail.h \
    configuration.h

OTHER_FILES += \
    simontouch.xml

LIBS += -lakonadi-kabc -lkabc -lkmime -lkdecore -lsoprano -lkdeui \
        -lakonadi-kde -lakonadi-contact -lakonadi-kmime \
        -leventsimulation -lnepomuk -lnepomukquery \
        -lmailtransport -lkpimidentities -lskype -lkdeclarative


