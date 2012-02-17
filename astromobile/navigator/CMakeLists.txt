set( navigator_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/navigator.cpp
)

qt4_add_dbus_adaptor(navigator_SRC info.echord.Astromobile.xml
        ${CMAKE_CURRENT_SOURCE_DIR}/navigator.h Navigator)

kde4_add_executable( navigator ${navigator_SRC} )


target_link_libraries( navigator ${QT_LIBRARIES} ${KDE4_KDEUI_LIBS}
		-L/opt/MetraLabs/lib
                 MLRoboticRobot MLRoboticBase MetraLabsBase
		uuid 
)
install (TARGETS navigator DESTINATION bin)
