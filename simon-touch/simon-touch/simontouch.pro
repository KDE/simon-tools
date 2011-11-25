# Add more folders to ship with the application, here
folder_01.source = qml/simontouch
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += xml dbus

symbian:TARGET.UID3 = 0xEAB67D3B

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

DEFINES = SKYPE_DEBUG_GLOBAL=14311

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility qdbus dbusadaptors
MOBILITY += multimedia

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components


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
    skypevoipprovider.cpp


SOURCES +=  libskype/skype.cpp \
            libskype/skypewindow.cpp \
            libskype/skypedbus/skypeconnection.cpp
HEADERS +=  libskype/skype.h \
            libskype/skypewindow.h \
            libskype/skypedbus/skypeconnection.h

DBUS_ADAPTORS = libskype/skypedbus/com.Skype.API.Client.xml

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
    simontouchstate.h \
    simontouchadapter.h \
    communicationcentral.h \
    contactsmodel.h \
    messagemodel.h \
    imageprovider.h \
    declarativeimageprovider.h \
    voipprovider.h \
    voipproviderfactory.h \
    skypevoipprovider.h

OTHER_FILES += \
    simontouch.xml

LIBS += -lakonadi-kabc -lkdecore -lakonadi-kde -lakonadi-contact -lakonadi-kmime -leventsimulation

































































