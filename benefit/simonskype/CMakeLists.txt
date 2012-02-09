project( simon_skype )
cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

find_package(KDE4 REQUIRED)
find_package(Eventsimulation REQUIRED)
find_package(LibSkype REQUIRED)

add_subdirectory(src)
