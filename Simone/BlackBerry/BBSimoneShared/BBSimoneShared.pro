TEMPLATE = lib
TARGET = SimoneShared
QT += network

blackberry {
        SOURCES += qnx/qsabackend.cpp
        HEADERS += qnx/qsabackend.h
        LIBS += -lasound
}

linux {
        SOURCES += alsa/alsabackend.cpp
        HEADERS += alsa/alsabackend.h
        LIBS += -lasound
        INCLUDEPATH += /usr/include/alsa
}

macx {
        OBJECTIVE_SOURCES +=  coreaudio/coreaudiobackend.mm
        HEADERS += coreaudio/coreaudiobackend.h
        LIBS += -framework Foundation -framework CoreAudio -framework AudioToolbox
}

SOURCES += simondconnector.cpp \
        settings.cpp \
        soundinput.cpp \
        recognitionresult.cpp \
        soundbackend.cpp

        #qmlapplicationviewer/qmlapplicationviewer.cpp \

HEADERS += simondconnector.h \
        simone.h \
        settings.h \
        simonprotocol.h \
        soundinput.h \
        recognitionresult.h \
        soundbackendclient.h \
        soundbackend.h

contains(QT_VERSION, ^4.*) {
  SOURCES += qmlapplicationviewer/qmlapplicationviewer.cpp
  HEADERS += qmlapplicationviewer/qmlapplicationviewer.h
}
