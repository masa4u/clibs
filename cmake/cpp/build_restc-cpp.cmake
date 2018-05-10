IF(BUILD_RESTCCPP)
    SET(RESTCCPP_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cpp/restc-cpp)
    SET(RESTCCPP_LIBRARY "restc-cpp.lib")
    SET(RESTCCPP_INCLUDE_DIR ${RESTCCPP_DIR}/include)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${RESTCCPP_LIBRARY}")
	include(ExternalProject)
        building_library("restc-cpp")
	#add_subdirectory(cmake/cpp/restc-cpp)
	ExternalProject_Add(restc-cpp 
		GIT_REPOSITORY "https://github.com/jgaa/restc-cpp.git"
		SOURCE_DIR cmake/cpp/restc-cpp)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${RESTCCPP_LIBRARY}")
ENDIF(BUILD_RESTCCPP)

