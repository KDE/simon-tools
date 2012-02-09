project(simonskype)

include_directories(${QT_INCLUDES} ${KDE4_INCLUDES}
	${QT_QTDBUS_INCLUDE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}
	${EVENTSIMULATION_INCLUDE_DIR}
	${SKYPE_INCLUDE_DIR}
)

set(
	simon_skype_SRCS
	main.cpp
	simonskype.cpp
)

kde4_add_executable(simonskype ${simon_skype_SRCS})

target_link_libraries(
	simonskype
	${SKYPE_LIBRARY} ${EVENTSIMULATION_LIBRARY}
	${KDE4_KDEUI_LIBS}
	${X11_X11_LIB}
)

install( TARGETS simonskype DESTINATION ${BIN_INSTALL_DIR} )
