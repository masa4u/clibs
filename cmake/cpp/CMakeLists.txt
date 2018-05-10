SET(TARGET_CPP restc-cpp) 

FOREACH(target ${TARGET_CPP})
  include(build_${target})
ENDFOREACH(target)
