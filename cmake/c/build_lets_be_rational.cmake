# --------------------------------------------------------------
# Let's Be Rational
IF(BUILD_LETS_BE_RATIONAL)
    SET(LETSBERATIONAL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/levmar)
    SET(LETSBERATIONAL_LIBRARY "lets_be_rational.lib")
    SET(LETSBERATIONAL_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/c/lets_be_rational)
    if(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/lets_be_rational.lib")
        building_library("Let's be rational")
        add_subdirectory(cmake/c/lets_be_rational)
    endif(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/lets_be_rational.lib")
ENDIF(BUILD_LETS_BE_RATIONAL)


