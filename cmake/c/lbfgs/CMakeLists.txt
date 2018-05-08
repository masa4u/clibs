file(GLOB _local_source 
      "src/*.hpp"
      "src/*.cpp"
    )
if(NOT WIN32)
endif(NOT WIN32)

add_library(lbfgs
  ${_local_source} 
  )
