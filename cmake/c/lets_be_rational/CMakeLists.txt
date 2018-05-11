file(GLOB _local_source 
      "*.h"
      "*.cpp"
    )
if(NOT WIN32)
    message(STATUS "remove xl addin function")
    list(REMOVE_ITEM _local_source ${CMAKE_CURRENT_SOURCE_DIR}/xlcall.cpp 
	    ${CMAKE_CURRENT_SOURCE_DIR}/xlcall.h 
	    ${CMAKE_CURRENT_SOURCE_DIR}/excel_registration.cpp)
endif(NOT WIN32)

add_library(lets_be_rational
  ${_local_source} 
  )

install(FILES lets_be_rational.h DESTINATION ${CMAKE_BINARY_DIR}/include)
