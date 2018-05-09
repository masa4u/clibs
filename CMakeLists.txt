# heck cmake required version
cmake_minimum_required(VERSION 3.10)

# Add some path to the cmake moduel search part
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} 
	${CMAKE_SOURCE_DIR}/cmake/modules
	${CMAKE_SOURCE_DIR}/cmake/c/levmar/cmake
	)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

macro(building_library name)
    message("=============================================================")
    message("= library: ${name}")
endmacro(building_library)


# set(CMAKE_VERBOSE_MAKEFILE ON)
list(APPEND CMAKE_MODULE_PATH
        "${CMAKE_CURRENT_LIST_DIR}/cmake"
        "${CMAKE_CURRENT_LIST_DIR}/cmake/c"
        "${CMAKE_CURRENT_LIST_DIR}/cmake/c/clapack/INCLUDE"
        "${CMAKE_CURRENT_LIST_DIR}/build/lib"
        )
set(dir ${CMAKE_CURRENT_SOURCE_DIR}/build)
SET(CMAKE_CACHEFILE_DIR ${dir}/cache)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${dir}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${dir}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${dir}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})

SET(CMAKE_LIBRARY_PATH ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

SET(EXTENTION_C ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c)
SET(EXTENTION_CPP ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cpp)


# fng project configuration files
project(clibs)

set(clibs_VERSION_MAJOR 1)
set(clibs_VERSION_MINOR 0)

#option(BUILD_GSL "build gsl" ON)
#option(BUILD_LEVMAR "build levmar" OFF)
#option(BUILD_CLAPACK "build CLAPACK" OFF)

SET(BUILD_GSL ON)
SET(BUILD_LEVMAR ON)
SET(BUILD_CLAPACK ON)
SET(BUILD_LETS_BE_RATIONAL ON)
SET(BUILD_LBFGS ON)
SET(BUILD_OPENSSL ON)
SET(BUILD_ZLIB ON)


#FIND_PACKAGE(BISON)
#FIND_PACKAGE(FLEX)

include("${EXTENTION_C}/CMakeLists.txt")


# ------------------------------------------------------
# done find package lib and setting local variables
link_directories(${CMAKE_LIBRARY_OUTPUT_DIRECTORY})


message(STATUS)
include("${EXTENTION_C}/report.cmake")

