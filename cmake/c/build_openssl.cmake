IF(BUILD_OPENSSL)
  SET(OPENSSL_CRYPTO_LIBRARY "crypto.lib")
  SET(OPENSSL_LIBRARY "ssl.lib")
  SET(OPENSSL_INCLUDE_DIR "${CMAKE_BINARY_DIR}/cmake/c/openssl-build")

  IF(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${OPENSSL_LIBRARY}")
      building_library("OpenSSL")

      include(ExternalProject)

      ExternalProject_Add(openssl
        URL "${CMAKE_CURRENT_SOURCE_DIR}/cmake/archive/OpenSSL-CMake-master.zip"
	SOURCE_DIR cmake/c/openssl
	BINARY_DIR cmake/c/openssl-build
	CMAKE_ARGS ${EXTENTION_C_ARGS}

	UPDATE_COMMAND ${CMAKE_COMMAND} -E copy ${EXTENTION_C}/openssl/openssl.cmake <SOURCE_DIR>/CMakeLists.txt &&
		       ${CMAKE_COMMAND} -E copy ${EXTENTION_C}/openssl/ssl.cmake <SOURCE_DIR>/ssl/CMakeLists.txt  &&
		       ${CMAKE_COMMAND} -E copy ${EXTENTION_C}/openssl/crypto.cmake <SOURCE_DIR>/crypto/CMakeLists.txt &&
		       ${CMAKE_COMMAND} -E copy ${EXTENTION_C}/openssl/apps.cmake <SOURCE_DIR>/apps/CMakeLists.txt 
	INSTALL_COMMAND ""
		)

  ENDIF(NOT EXISTS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${OPENSSL_LIBRARY}")
ENDIF(BUILD_OPENSSL)
