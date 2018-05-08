# -------------------------------------------
# levmar

IF(BUILD_LEVMAR)
    
    SET(LEVMAR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/levmar)
    SET(LEVMAR_LIBRARY "levmar.lib")
    SET(LEVMAR_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c)
    SET(BUILD_DEMO OFF)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/levmar.lib")
        add_subdirectory(cmake/c/levmar/src)
    building_library("levmar")
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/levmar.lib")
ENDIF(BUILD_LEVMAR)


