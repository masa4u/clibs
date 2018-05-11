# -----------------------------------------------------------------------
# GSL
IF(BUILD_GSL)
    SET(GSL_LIBRARY_DIR ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    if(WIN32)
        SET(GSL_LIBRARY gsl.lib)
        SET(GSL_CBLAS_LIBRARY gslcblas.lib)
    else()
        SET(GSL_LIBRARY gsl)
        SET(GSL_CBLAS_LIBRARY gslcblas)
    endif()

    if(NOT EXISTS "${GSL_LIBRARY_DIR}/${GSL_LIBRARY}" OR
            NOT EXISTS "${GSL_LIBRARY_DIR}/${GSL_CBLAS_LIBRARY}")
        building_library("gsl")
        include(ExternalProject)

        ExternalProject_Add(gsl
		URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/gsl-master.zip"
		SOURCE_DIR cmake/c/gsl
		BINARY_DIR cmake/c/gsl-build
		CMAKE_ARGS ${EXTENTION_C_ARGS}
		    -DGSL_DISABLE_WARNINGS=TRUE
		    -DGSL_DISABLE_TESTS=TRUE
		    -DGSL_INSTALL=TRUE
		    -DGSL_INCLUDE_DIR=<SOURCE_DIR>/..
		)
    else()
      SET(GSL_INCLUDE_DIR ${CMAKE_BINARY_DIR}/include)
      #SET(GSL_CBLAS_INCLUDE_DIRS ${CMAKE_BINARY_DIR}/lib)
      #SET(CBLAS_INCLUDE_DIRS "${GSL_INCLUDE_DIR}/gsl/cblas")
      #SET(CBLAS_LIBRARY ${GSL_CBLAS_LIBRARY})

      find_package(GSL REQUIRED)
      #find_package(CBLAS REQUIRED)
    endif()
ENDIF(BUILD_GSL)
