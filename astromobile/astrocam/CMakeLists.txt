set( astrocam_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/astrocam.cpp
)

qt4_add_dbus_adaptor(astrocam_SRC info.echord.Astromobile.xml
        ${CMAKE_CURRENT_SOURCE_DIR}/astrocam.h Astrocam)

kde4_add_executable( astrocam ${astrocam_SRC} )


target_link_libraries( astrocam ${QT_LIBRARIES} ${QT_QTNETWORK_LIBRARY} ${KDE4_KDEUI_LIBS})

install (TARGETS astrocam DESTINATION bin)
