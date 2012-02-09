project(libskype)

find_package(Qt4 COMPONENTS QtCore QtDbus QtGui)
find_package(KDE4 REQUIRED)

add_definitions (${QT_DEFINITIONS} ${KDE4_DEFINITIONS})

include_directories(${QT_INCLUDES} ${KDE4_INCLUDES}
	${QT_QTDBUS_INCLUDE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
)

add_definitions(-DSKYPE_DEBUG_GLOBAL=14311)

set(
	skypedbus_SRCS
	skypedbus/skypeconnection.cpp
)

QT4_ADD_DBUS_ADAPTOR(
	skypedbus_SRCS
	skypedbus/com.Skype.API.Client.xml
	skypedbus/skypeconnection.h
	SkypeConnection
	skypeadaptor
	SkypeAdaptor
)

set(
	libskype_SRCS
	skype.cpp
)

set( libskype_HDRS
  skype_export.h
  skype.h
)

if(UNIX)
set(
	libskype_SRCS
	${libskype_SRCS}
	skypewindow.cpp
	)
endif(UNIX)

set(
	libskype_SRCS
	${skypedbus_SRCS}
	${libskype_SRCS}
)

kde4_add_library( skype  SHARED ${libskype_SRCS} )

if(UNIX)
target_link_libraries(
	skype
	${KDE4_KDEUI_LIBS}
	${X11_X11_LIB}
)
else(UNIX)
target_link_libraries(
	skype
	${KDE4_KDEUI_LIBS}
)
endif(UNIX)

install( TARGETS skype DESTINATION ${LIB_INSTALL_DIR} )
install( FILES ${libskype_HDRS}
  DESTINATION ${INCLUDE_INSTALL_DIR}/skype
  COMPONENT libskype
)
