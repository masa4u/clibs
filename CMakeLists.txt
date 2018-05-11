# heck cmake required version
cmake_minimum_required(VERSION 3.9.2)

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
	"${CMAKE_CURRENT_LIST_DIR}/cmake/cpp"
	"${CMAKE_CURRENT_LIST_DIR}/cmake/cpp/restc-cpp/cmake_scripts"
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

## Extention: C
SET(BUILD_TARGET GSL LEVMAR CLAPACK LETS_BE_RATIONAL LBFGS ZLIB OPENSSL)
FOREACH(TARGET ${BUILD_TARGET})
  SET(BUILD_${TARGET} ON)
ENDFOREACH(TARGET)

## Extention: CPP
SET(BOOST_ROOT "E:/fng/cpp-lib/boost_1_65_1")
SET(BOOST_LIBRARYDIR "${BOOST_ROOT}/stage/win32/lib")
SET(BUILD_RESTCCPP OFF)


#FIND_PACKAGE(BISON)
#FIND_PACKAGE(FLEX)

include("${EXTENTION_C}/CMakeLists.txt")
include("${EXTENTION_CPP}/CMakeLists.txt")



# ------------------------------------------------------
# done find package lib and setting local variables
link_directories(${CMAKE_LIBRARY_OUTPUT_DIRECTORY})


message(STATUS)
include("${EXTENTION_C}/report.cmake")

