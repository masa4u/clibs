IF(BUILD_LBFGS)
    SET(LBFGS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/lbfgs)
    SET(LBFGS_LIBRARY "lbfgs.lib")
    SET(LBFGS_INCLUDE_DIR ${LBFGS_DIR}/include)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${LBFGS_LIBRARY}")
        building_library("L-BFSGS-B")
        add_subdirectory(cmake/c/lbfgs)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${LBFGS_LIBRARY}")
ENDIF(BUILD_LBFGS)

