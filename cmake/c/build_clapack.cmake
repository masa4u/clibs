# ---------------------------------------------------------------------------
# CLAPACK
IF(BUILD_CLAPACK)
    SET(CLAPACK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/clapack/INCLUDE")
    SET(CLAPACK_LIBRARY "lapack.lib")
    SET(CLAPACK_INCLUDE_DIRS ${CLAPACK_DIR})
    SET(F2C_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/clapack/F2CLIBS/libf2c")
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CLAPACK_LIBRARY}")
        SET(CLAPACK_BUILD_TESTS OFF)
        building_library("CLAPACK")
        add_subdirectory(cmake/c/clapack)
    endif()
    find_package(CLAPACK)
    SET(F2C_LIBRARY "f2c.lib")
    find_package(F2C)
ENDIF(BUILD_CLAPACK)

