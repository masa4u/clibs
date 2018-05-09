SET(TARGET_C gsl clapack levmar lets_be_rational lbfgs openssl)

FOREACH(target ${TARGET_C})
  include(build_${target})
ENDFOREACH(target)
