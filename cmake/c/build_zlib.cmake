# -------------------------------------------
# zlib

IF(BUILD_ZLIB)
    
    SET(ZLIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/zlib)
    SET(ZLIB_LIBRARY "zlib.lib")
    SET(ZLIB_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/zlib.lib")
      building_library("zlib")
      include(ExternalProject)

      ExternalProject_Add(zlib
		URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/zlib-master.zip"
		SOURCE_DIR cmake/c/zlib
		BINARY_DIR cmake/c/zlib-build
		CMAKE_ARGS ${EXTENTION_C_ARGS}
		)
    else()
      find_package(ZLIB REQUIRED)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/zlib.lib")
ENDIF(BUILD_ZLIB)


