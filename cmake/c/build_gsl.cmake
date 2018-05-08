# -----------------------------------------------------------------------
# GSL
IF(BUILD_GSL)
    SET(GSL_DISABLE_WARNINGS TRUE)
    SET(GSL_DISABLE_TESTS TRUE)
    SET(GSL_INSTALL FALSE)

    SET(GSL_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c)
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

        add_subdirectory(cmake/c/gsl)
        #add_subdirectory(test)
    endif()
    find_package(GSL REQUIRED)
    SET(CBLAS_INCLUDE_DIRS "${GSL_INCLUDE_DIR}/gsl/cblas")
    # message("FIND CBLAS")
    find_package(CBLAS)
ENDIF(BUILD_GSL)


