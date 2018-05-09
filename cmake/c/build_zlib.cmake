# -------------------------------------------
# zlib

IF(BUILD_ZLIB)
    
    SET(ZLIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/zlib)
    SET(ZLIB_LIBRARY "zlib.lib")
    SET(ZLIB_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/zlib.lib")
    add_subdirectory(cmake/c/zlib)
    building_library("zlib")
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/zlib.lib")
ENDIF(BUILD_ZLIB)


