project(astromobile)
find_package(KDE4 REQUIRED)
find_package(Qt4 COMPONENTS QtCore QtDBus REQUIRED)
include(FindQt4)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include_directories(
        /opt/MetraLabs/MetraLabsBase/include /opt/MetraLabs/MLRobotic/include
	${KDE4_INCLUDE_DIR}/KDE ${KDE4_INCLUDE_DIR} ${QT_INCLUDES})

add_definitions(-DM_LINUX=1 -D_REENTRANT)

add_subdirectory(astrocam)
add_subdirectory(astrologic)
#add_subdirectory(locator)
#add_subdirectory(navigator)
INSTALL (FILES astromobile.conf DESTINATION ${SYSCONF_INSTALL_DIR}/dbus-1/system.d/)
