# ---------------------------------------------------------------------------
# CLAPACK
IF(BUILD_CLAPACK)
    SET(CLAPACK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/clapack/INCLUDE")
    SET(CLAPACK_LIBRARY "lapack.lib")
    SET(CLAPACK_INCLUDE_DIRS ${CLAPACK_DIR})
    SET(F2C_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/clapack/F2CLIBS/libf2c")
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CLAPACK_LIBRARY}")
        building_library("CLAPACK")
        include(ExternalProject)

        ExternalProject_Add(clapack
		URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/clapack-master.zip"
		SOURCE_DIR cmake/c/clapack
		BINARY_DIR cmake/c/clapack-build
		CMAKE_ARGS ${EXTENTION_C_ARGS}
		-DF2C_INCLUDE_DIRS=<SOURCE_DIR>/F2CLIBS/libf2c
		-DCLAPACK_BUILD_TESTS=OFF
		INSTALL_DIR ${CMKAE_BINARY_DIR}
		)
    else()
      SET(CBLAS_INCLUDE_DIRS ${CMAKE_BINARY_DIR}/include)
      find_package(CLAPACK)
      SET(F2C_LIBRARY "f2c.lib")
      find_package(F2C)
    endif()
ENDIF(BUILD_CLAPACK)

