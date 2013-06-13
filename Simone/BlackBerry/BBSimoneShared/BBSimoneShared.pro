TEMPLATE = lib
TARGET = SimoneShared

blackberry {
        SOURCES += qnx/qsabackend.cpp
        HEADERS += qnx/qsabackend.h
        LIBS += -lasound
}

unix:!blackberry {
        SOURCES += alsa/alsabackend.cpp
        HEADERS += alsa/alsabackend.h
        LIBS += -lasound
        INCLUDEPATH += /usr/include/alsa
}

SOURCES += simondconnector.cpp \
        settings.cpp \
        qmlapplicationviewer/qmlapplicationviewer.cpp \
        soundinput.cpp \
        recognitionresult.cpp \
        soundbackend.cpp

HEADERS += simondconnector.h \
        simone.h \
        qmlapplicationviewer/qmlapplicationviewer.h \
        settings.h \
        simonprotocol.h \
        soundinput.h \
        recognitionresult.h \
        soundbackend.h \
        soundbackendclient.h \
        soundbackend.h
