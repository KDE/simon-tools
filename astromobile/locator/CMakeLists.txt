set( locator_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/locator.cpp
)

qt4_add_dbus_adaptor(locator_SRC info.echord.Astromobile.xml
  ${CMAKE_CURRENT_SOURCE_DIR}/locator.h Locator)

kde4_add_executable( locator ${locator_SRC} )

target_link_libraries( locator ${QT_LIBRARIES} ${KDE4_KDEUI_LIBS} )

install (TARGETS locator DESTINATION bin)
