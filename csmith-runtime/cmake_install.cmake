# Install script for directory: /home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libcsmith.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE STATIC_LIBRARY FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/libcsmith.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}/usr/local/lib/libcsmith.so.0.0.0"
      "$ENV{DESTDIR}/usr/local/lib/libcsmith.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libcsmith.so.0.0.0;/usr/local/lib/libcsmith.so.0")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/libcsmith.so.0.0.0"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/libcsmith.so.0"
    )
  foreach(file
      "$ENV{DESTDIR}/usr/local/lib/libcsmith.so.0.0.0"
      "$ENV{DESTDIR}/usr/local/lib/libcsmith.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libcsmith.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libcsmith.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/usr/local/lib/libcsmith.so"
         RPATH "")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libcsmith.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/libcsmith.so")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libcsmith.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libcsmith.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/usr/local/lib/libcsmith.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/csmith-2.3.0/csmith.h;/usr/local/include/csmith-2.3.0/csmith_minimal.h;/usr/local/include/csmith-2.3.0/custom_limits.h;/usr/local/include/csmith-2.3.0/custom_stdint_x86.h;/usr/local/include/csmith-2.3.0/platform_avr.h;/usr/local/include/csmith-2.3.0/platform_generic.h;/usr/local/include/csmith-2.3.0/platform_msp430.h;/usr/local/include/csmith-2.3.0/random_inc.h;/usr/local/include/csmith-2.3.0/safe_abbrev.h;/usr/local/include/csmith-2.3.0/stdint_avr.h;/usr/local/include/csmith-2.3.0/stdint_ia32.h;/usr/local/include/csmith-2.3.0/stdint_ia64.h;/usr/local/include/csmith-2.3.0/stdint_msp430.h;/usr/local/include/csmith-2.3.0/volatile_runtime.c;/usr/local/include/csmith-2.3.0/volatile_runtime.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/csmith-2.3.0" TYPE FILE FILES
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/csmith.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/csmith_minimal.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/custom_limits.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/custom_stdint_x86.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/platform_avr.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/platform_generic.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/platform_msp430.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/random_inc.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/safe_abbrev.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/stdint_avr.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/stdint_ia32.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/stdint_ia64.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/stdint_msp430.h"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/volatile_runtime.c"
    "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/volatile_runtime.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/csmith-2.3.0/safe_math.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/csmith-2.3.0" TYPE FILE FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/safe_math.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/csmith-2.3.0/safe_math_macros.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/csmith-2.3.0" TYPE FILE FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/safe_math_macros.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/csmith-2.3.0/safe_math_macros_notmp.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/csmith-2.3.0" TYPE FILE FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/safe_math_macros_notmp.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/csmith-2.3.0/windows/stdint.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/csmith-2.3.0/windows" TYPE FILE FILES "/home/haejun/csmith-llvm-cov/csmith-2.3.0/runtime/windows/stdint.h")
endif()

