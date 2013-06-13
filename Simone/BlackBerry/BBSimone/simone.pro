TEMPLATE = app
TARGET = BBSimone
DEPENDPATH += .

BBSIMONECOMMONPATH = ../build-BBSimoneShared-Qt_4_8_3_prefix-Release

QT += declarative
OTHER_FILES += \
        src/qml/simone/main.qml \
        src/qml/simone/EditableComboBox.qml \
        src/qml/simone/ComboBox.qml \
        src/qml/simone/Button.qml \
        src/qml/simone/LineEdit.qml \
        src/qml/simone/CheckBox.qml \
        src/qml/simone/AnimatedItem.qml \
        src/qml/simone/ProgressBar.qml \
        src/qml/simone/Dialog.qml \
        src/qml/simone/ConnectionSettings.qml \
        src/qml/simone/ActiveConsole.qml


blackberry {
	QMAKE_LFLAGS += '-Wl,-rpath,\'./app/native/lib\''
	PACKAGE_ARGS = \
                $${PWD}/bar-descriptor.xml $$TARGET \
                -e $${PWD}/simone86.png res/simone86.png \
                -e $${PWD}/splash.png res/splash.png \
                -e $${BBSIMONECOMMONPATH}/libSimoneShared.so.1.0.0 lib/libSimoneShared.so.1 \
                -e $$[QT_INSTALL_LIBS]/libQtCore.so.4 lib/libQtCore.so.4 \
		-e $$[QT_INSTALL_LIBS]/libQtGui.so.4 lib/libQtGui.so.4 \
		-e $$[QT_INSTALL_LIBS]/libQtOpenGL.so.4 lib/libQtOpenGL.so.4 \
		-e $$[QT_INSTALL_LIBS]/libQtNetwork.so.4 lib/libQtNetwork.so.4 \
                -e $$[QT_INSTALL_LIBS]/libQtDeclarative.so.4 lib/libQtDeclarative.so.4 \
                -e $$[QT_INSTALL_LIBS]/libQtSql.so.4 lib/libQtSql.so.4 \
                -e $$[QT_INSTALL_LIBS]/libQtSvg.so.4 lib/libQtSvg.so.4 \
                -e $$[QT_INSTALL_LIBS]/libQtScript.so.4 lib/libQtScript.so.4 \
                -e $$[QT_INSTALL_LIBS]/libQtXmlPatterns.so.4 lib/libQtXmlPatterns.so.4 \
		-e $$[QT_INSTALL_PLUGINS]/platforms/libblackberry.so plugins/platforms/libblackberry.so \
                -e $${PWD}/src/qml/ res/qml/

	package.target = $${TARGET}.bar
	package.depends = $$TARGET
	package.commands = blackberry-nativepackager \
		-package $${TARGET}.bar \
		-devMode -debugToken $$(DEBUG_TOKEN) \
		$${PACKAGE_ARGS}

	QMAKE_EXTRA_TARGETS += package

	OTHER_FILES += bar-descriptor.xml
	OTHER_FILES += simone86.png
       # INCLUDEPATH += ${QNX_TARGET}/usr/include/sys
}

SOURCES += src/main.cpp \
        src/simoneview.cpp \
        src/qmlsimoneview.cpp

HEADERS += \
        src/simoneview.h \
        src/qmlsimoneview.h 


INCLUDEPATH += ../BBSimoneShared
LIBS += -L$${BBSIMONECOMMONPATH} -lSimoneShared
