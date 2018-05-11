# -------------------------------------------
# levmar

IF(BUILD_LEVMAR)
    
    SET(LEVMAR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/levmar)
    SET(LEVMAR_LIBRARY "levmar.lib")
    
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/levmar.lib")
      building_library("levmar")
      include(ExternalProject)

      ExternalProject_Add(levmar
		URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/levmar-master.zip"
		SOURCE_DIR cmake/c/levmar
		BINARY_DIR cmake/c/levmar-build
		CMAKE_ARGS ${EXTENTION_C_ARGS}
		    -DBUILD_DEMO=OFF
		)
    else()
      SET(LEVMAR_INCLUDE_DIR ${CMAKE_BINARY_DIR}/include)
      find_package(LEVMAR REQUIRED)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/levmar.lib")
ENDIF(BUILD_LEVMAR)


