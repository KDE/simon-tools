set( astrologic_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/astrologic.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/location.cpp
)

qt4_add_dbus_adaptor(astrologic_SRC info.echord.Astromobile.xml
        ${CMAKE_CURRENT_SOURCE_DIR}/astrologic.h AstroLogic)

kde4_add_executable( astrologic ${astrologic_SRC} )

target_link_libraries( astrologic ${QT_LIBRARIES} ${KDE4_KDEUI_LIBS}
${QT_QTXML_LIBRARIES})

install (TARGETS astrologic DESTINATION bin)
install (FILES locations.xml DESTINATION ${DATA_INSTALL_DIR}/astrologic)
