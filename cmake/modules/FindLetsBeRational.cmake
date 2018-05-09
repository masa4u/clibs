# - Try to find LETSBERATIONAL
# Once done this will define
#
#  LETSBERATIONAL_FOUND			- system has LETSBERATIONAL
#  LETSBERATIONAL_INCLUDE_DIR		- the LETSBERATIONAL include directory
#  LETSBERATIONAL_LIBRARY		- link library to use LETSBERATIONAL

IF (LETSBERATIONAL_INCLUDE_DIR)
  #already in cache
  SET(LETSBERATIONAL_FIND_QUIETLY TRUE)
ENDIF(LETSBERATIONAL_INCLUDE_DIR)

FIND_PATH(LETSBERATIONAL_INCLUDE_DIR lets_be_rational.h
          PATHS /usr/include)
FIND_LIBRARY(LETSBERATIONAL_LIBRARY
             NAMES lets_be_rational
             PATHS /usr/lib64 /usr/lib)

# handle the QUIETLY and REQUIRED arguments and set LETSBERATIONAL_FOUND to TRUE if 
# all listed variables are TRUE

IF(LETSBERATIONAL_INCLUDE_DIR AND LETSBERATIONAL_LIBRARY)
  SET(LETSBERATIONAL_FOUND TRUE)
ELSE(LETSBERATIONAL_INCLUDE_DIR AND LETSBERATIONAL_LIBRARY)
  SET(LETSBERATIONAL_FOUND FALSE)
ENDIF(LETSBERATIONAL_INCLUDE_DIR AND LETSBERATIONAL_LIBRARY)

INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(LETSBERATIONAL DEFAULT_MSG LETSBERATIONAL_LIBRARY LETSBERATIONAL_INCLUDE_DIR)

MARK_AS_ADVANCED(
  LETSBERATIONAL_LIBRARY
  LETSBERATIONAL_INCLUDE_DIR)
set( LETSBERATIONAL_INCLUDE_DIRS ${LETSBERATIONAL_INCLUDE_DIR} )


if( LETSBERATIONAL_FOUND AND NOT TARGET LETSBERATIONAL::lets_be_rational)
  add_library( LETSBERATIONAL::lets_be_rational UNKNOWN IMPORTED )
  set_target_properties( LETSBERATIONAL::lets_be_rational PROPERTIES
      IMPORTED_LOCATION                 "${LETSBERATIONAL_LIBRARY}"
      INTERFACE_INCLUDE_DIRECTORIES     "${LETSBERATIONAL_INCLUDE_DIRS}"
      IMPORTED_LINK_INTERFACE_LANGUAGES "C" )
endif()