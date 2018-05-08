##
## Find LAPACK and BLAS libraries, or their optimised versions
##

if(APPLE)
  set(USE_LAPACK true)
  set(USE_BLAS   true)
  
  ## Under MacOS, the current version of FindCLAPACK can get confused between two incompatible
  ## versions of "clapack.h" (one provided by the system and one provided by ATLAS).
  ## As such, use of ATLAS under MacOS is disabled for now.
  set(CMAKE_CXX_FLAGS "-framework Accelerate ${CMAKE_CXX_FLAGS}")  # or "-framework accelerate" ?
  set(CMAKE_C_FLAGS "-framework Accelerate ${CMAKE_C_FLAGS}")  # or "-framework accelerate" ?
  message(STATUS "MacOS X detected. Added '-framework Accelerate' to compiler flags")
  
else()
  include(${CMAKE_SOURCE_DIR}/CMake/FindMKL.cmake)
  include(${CMAKE_SOURCE_DIR}/CMake/FindACMLMP.cmake)
  include(${CMAKE_SOURCE_DIR}/CMake/FindACML.cmake)
  
  message(STATUS "   MKL_FOUND   = ${MKL_FOUND}")
  message(STATUS "ACMLMP_FOUND   = ${ACMLMP_FOUND}")
  message(STATUS "  ACML_FOUND   = ${ACML_FOUND}")
  
  if(MKL_FOUND OR ACMLMP_FOUND OR ACML_FOUND)
    
    set(USE_BLAS   true)
    set(USE_LAPACK true)
    
    message(STATUS "")
    message(STATUS "*** If the MKL or ACML libraries are installed in")
    message(STATUS "*** /opt or /usr/local, make sure the run-time linker can find them.")
    message(STATUS "*** On Linux systems this can be done by editing /etc/ld.so.conf")
    message(STATUS "*** or modifying the LD_LIBRARY_PATH environment variable.")
    message(STATUS "*** On systems with SELinux enabled (eg. Fedora, RHEL),")
    message(STATUS "*** you may need to change the SELinux type of all MKL/ACML libraries")
    message(STATUS "*** to fix permission problems that may occur during run-time.")
    message(STATUS "*** See README.txt for more information")
    message(STATUS "")
    
  else()
    
    include(${CMAKE_SOURCE_DIR}/CMake/FindLAPACK.cmake)
    include(${CMAKE_SOURCE_DIR}/CMake/FindOpenBLAS.cmake)
    include(${CMAKE_SOURCE_DIR}/CMake/FindBLAS.cmake)
    include(${CMAKE_SOURCE_DIR}/CMake/FindCLAPACK.cmake)
    include(${CMAKE_SOURCE_DIR}/CMake/FindCBLAS.cmake)
    
    message(STATUS "  LAPACK_FOUND = ${LAPACK_FOUND}")
    message(STATUS "    BLAS_FOUND = ${BLAS_FOUND}")
    message(STATUS "OpenBLAS_FOUND = ${OpenBLAS_FOUND}")
    message(STATUS " CLAPACK_FOUND = ${CLAPACK_FOUND}")
    message(STATUS "   CBLAS_FOUND = ${CBLAS_FOUND}")
    
    if(LAPACK_FOUND)
      set(USE_LAPACK true)
    endif()
    
    if(BLAS_FOUND)
      set(USE_BLAS true)
    endif()
    
    if(OpenBLAS_FOUND AND CLAPACK_FOUND AND CBLAS_FOUND)
      message(STATUS "")
      message(STATUS "*** WARNING: both OpenBLAS and ATLAS have been found; ATLAS will not be used")
    endif()
    
    if(OpenBLAS_FOUND)
      
      set(USE_BLAS true)
      
      message(STATUS "")
      message(STATUS "*** If the OpenBLAS library is installed in")
      message(STATUS "*** /usr/local/lib or /usr/local/lib64")
      message(STATUS "*** make sure the run-time linker can find it.")
      message(STATUS "*** On Linux systems this can be done by editing /etc/ld.so.conf")
      message(STATUS "*** or modifying the LD_LIBRARY_PATH environment variable.")
      message(STATUS "")
      
    else()
      
      if(CLAPACK_FOUND AND CBLAS_FOUND)
        message(STATUS "CLAPACK_INCLUDE_DIR = ${CLAPACK_INCLUDE_DIR}")
        message(STATUS "  CBLAS_INCLUDE_DIR = ${CBLAS_INCLUDE_DIR}")
        
        if(${CLAPACK_INCLUDE_DIR} STREQUAL ${CBLAS_INCLUDE_DIR})
          set(USE_ATLAS true)
          set(ATLAS_INCLUDE_DIR ${CLAPACK_INCLUDE_DIR})
        endif()
      endif()
      
    endif()
    
  endif()

endif()


if(MKL_FOUND OR ACMLMP_FOUND OR ACML_FOUND)
  
  if(MKL_FOUND)
    
    set(LA_LIBS ${LA_LIBS} ${MKL_LIBRARIES})

    if(ACMLMP_FOUND OR ACML_FOUND)
      message(STATUS "*** Intel MKL as well as AMD ACML libraries were found.")
      message(STATUS "*** Using only the MKL library to avoid linking conflicts.")
    endif()
    
  else()
    
    if(ACMLMP_FOUND)
      set(LA_LIBS ${LA_LIBS} ${ACMLMP_LIBRARIES})
      
      message(STATUS "*** Both single-core and multi-core ACML libraries were found.")
      message(STATUS "*** Using only the multi-core library to avoid linking conflicts.")
    else()
      if(ACML_FOUND)
        set(LA_LIBS ${LA_LIBS} ${ACML_LIBRARIES})
      endif()
    endif()
    
  endif()
  
else()
  
  if(USE_BLAS STREQUAL true)
    if(OpenBLAS_FOUND)
      set(LA_LIBS ${LA_LIBS} ${OpenBLAS_LIBRARIES})
    else()
      set(LA_LIBS ${LA_LIBS} ${BLAS_LIBRARIES})
    endif()
  endif()
  
  if(USE_LAPACK STREQUAL true)
    set(LA_LIBS ${LA_LIBS} ${LAPACK_LIBRARIES})
  endif()
  
  if(USE_ATLAS STREQUAL true)
    set(LA_LIBS ${LA_LIBS} ${CBLAS_LIBRARIES})
    set(LA_LIBS ${LA_LIBS} ${CLAPACK_LIBRARIES})
  endif()
  
endif()

