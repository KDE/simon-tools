project(benefit)
cmake_minimum_required(VERSION 2.6)
find_package(KDE4 REQUIRED)

find_package (KdepimLibs 4.5.60)

if (KDEPIMLIBS_FOUND)
add_subdirectory(speechcal)
endif (KDEPIMLIBS_FOUND)

if(NOT WIN32)
    add_subdirectory(simonskype)
endif(NOT WIN32)
add_subdirectory(simonstatus)
