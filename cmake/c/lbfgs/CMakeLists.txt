file(GLOB _local_source 
      "src/*.hpp"
      "src/*.cpp"
    )
if(NOT WIN32)
endif(NOT WIN32)

add_library(lbfgs
  ${_local_source} 
  )
install(FILES src/lbfgsb.hpp DESTINATION ${CMAKE_BINARY_DIR}/include)
