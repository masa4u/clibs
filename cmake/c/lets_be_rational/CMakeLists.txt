file(GLOB _local_source 
      "*.h"
      "*.cpp"
    )
if(NOT WIN32)
    message(STATUS "remove xl addin function")
    list(REMOVE_ITEM _local_source xlcall.cpp xlcall.h)
endif(NOT WIN32)

add_library(lets_be_rational
  ${_local_source} 
  )

install(FILES lets_be_rational.h DESTINATION ${CMAKE_BINARY_DIR}/include)
