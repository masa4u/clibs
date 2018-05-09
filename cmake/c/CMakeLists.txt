SET(TARGET_C gsl clapack levmar lets_be_rational lbfgs openssl zlib)

FOREACH(target ${TARGET_C})
  include(build_${target})
ENDFOREACH(target)
