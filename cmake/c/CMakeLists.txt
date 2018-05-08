SET(TARGET_C gsl clapack levmar lets_be_rational lbfgs)

FOREACH(target ${TARGET_C})
  include(build_${target})
ENDFOREACH(target)
