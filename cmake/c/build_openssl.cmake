IF(BUILD_OPENSSL)
  SET(BUILD_OBJECT_LIBRARY_ONLY OFF)
  SET(OPENSSL_CRYPTO_LIBRARY "crypto.lib")
  SET(OPENSSL_LIBRARY "ssl.lib")
  SET(OPENSSL_INCLUDE_DIR "${EXTENTION_C}")

  include_directories("cmake/c")

  IF(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${OPENSSL_LIBRARY}")
	  #include_directories ( BEFORE SYSTEM ${EXTENTION_C}/openssl/crypto ${EXTENTION_C}/openssl/ssl
	  #    ${EXTENTION_C}/openssl ${EXTENTION_C} crypto .)
    include_directories ( BEFORE SYSTEM 
	  ${CMAKE_CURRENT_BINARY_DIR}/cmake/c/openssl/crypto 
	  ${CMAKE_CURRENT_BINARY_DIR}/cmake/c/openssl/ssl 
	  ${EXTENTION_C}/openssl/crypto ${EXTENTION_C}/openssl )


    add_definitions( -DOPENSSL_NO_ASM )

    if( WIN32 AND NOT CYGWIN )
      add_definitions( -DOPENSSL_SYSNAME_WIN32 )
      add_definitions( -DWIN32_LEAN_AND_MEAN )
    endif ( )

    building_library("OpenSSL")
    #add_subdirectory(cmake/c/openssl)
    add_subdirectory(cmake/c/openssl/crypto )
    add_subdirectory(cmake/c/openssl/ssl )
    file( COPY ${EXTENTION_C}/openssl/e_os2.h DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/openssl )

  ENDIF(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${OPENSSL_LIBRARY}")
ENDIF(BUILD_OPENSSL)
