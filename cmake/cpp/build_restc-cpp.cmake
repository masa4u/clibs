IF(BUILD_RESTCCPP)
    SET(RESTCCPP_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cpp/restc-cpp)
    SET(RESTCCPP_LIBRARY "restc-cpp.lib")
    SET(RESTCCPP_INCLUDE_DIR ${RESTCCPP_DIR}/include)
    SET(ZLIB_LIBRARY zlib.lib)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${RESTCCPP_LIBRARY}")
	include(ExternalProject)
        building_library("restc-cpp")
	#add_subdirectory(cmake/cpp/restc-cpp)

	SET(RESTCCPP_PREFIX_PATH ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
			"${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/zlib"
			"${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/openssl")
	SET(OPENSSL_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/openssl")

	ExternalProject_Add(restc-cpp 
		#GIT_REPOSITORY "https://github.com/jgaa/restc-cpp.git"
		URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/restc-cpp-master.zip"
		CMAKE_ARGS "${CMAKE_ARGS} -DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR} -DOPENSSL_INCLUDE_DIR=${OPENSSL_ROOT_DIR}/../ -DCMAKE_PREFIX_PATH=${RESTCCPP_PREFIX_PATH}"
		SOURCE_DIR cmake/cpp/restc-cpp-src
		BINARY_DIR cmake/cpp/restc-cpp-build
		)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${RESTCCPP_LIBRARY}")
ENDIF(BUILD_RESTCCPP)

