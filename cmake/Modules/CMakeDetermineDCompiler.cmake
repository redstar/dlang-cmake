# Determine the compiler to use for D programs
#
# Sets the following variables:
#   CMAKE_D_COMPILER
#   CMAKE_D_COMPILER_ID
#   CMAKE_D_COMPILER_VERSION

include(${CMAKE_ROOT}/Modules/CMakeDetermineCompiler.cmake)

# Load system-specific compiler preferences for this language.
include(Platform/${CMAKE_SYSTEM_NAME}-C OPTIONAL)

if(NOT CMAKE_D_COMPILER)
  # TODO: ENV DC?
  # List compilers to try
  set(CMAKE_D_COMPILER_LIST dmd ldmd2 gdmd ldc2 gdc)
  _cmake_find_compiler(D)
else()
  _cmake_find_compiler_path(D)
endif()
mark_as_advanced(CMAKE_D_COMPILER)

# Set compiler ID
if (CMAKE_D_COMPILER)
  get_filename_component(__CMAKE_D_COMPILER_NAME ${CMAKE_D_COMPILER} NAME_WE)
  if (__CMAKE_D_COMPILER_NAME STREQUAL "dmd")
    set(CMAKE_D_COMPILER_ID "DigitalMars")
    set(CMAKE_D_COMPILER_IS_DMD_COMPAT "TRUE")
  elseif (__CMAKE_D_COMPILER_NAME STREQUAL "ldmd2")
    set(CMAKE_D_COMPILER_ID "LDMD")
    set(CMAKE_D_COMPILER_IS_DMD_COMPAT "TRUE")
  elseif (__CMAKE_D_COMPILER_NAME STREQUAL "ldc2")
    set(CMAKE_D_COMPILER_ID "LDC")
    set(CMAKE_D_COMPILER_IS_DMD_COMPAT "FALSE")
  elseif (__CMAKE_D_COMPILER_NAME STREQUAL "gdc")
    set(CMAKE_D_COMPILER_ID "GDC")
    set(CMAKE_D_COMPILER_IS_DMD_COMPAT "FALSE")
  elseif (__CMAKE_D_COMPILER_NAME STREQUAL "gdmd")
    set(CMAKE_D_COMPILER_ID "GDMD")
    set(CMAKE_D_COMPILER_IS_DMD_COMPAT "TRUE")
  endif()

  # Older versions of ldmd do not have --version cmdline option, but the error message still contains the version info in the first line.
  execute_process(COMMAND ${CMAKE_D_COMPILER} --version
                  OUTPUT_VARIABLE CMAKE_D_COMPILER_VERSION
                  ERROR_VARIABLE CMAKE_D_COMPILER_VERSION
                  ERROR_QUIET)
  string(REGEX MATCH "^[^\r\n:]*" CMAKE_D_COMPILER_VERSION "${CMAKE_D_COMPILER_VERSION}")

  # Display the final identification result.
  if(CMAKE_D_COMPILER_ID)
    if(CMAKE_D_COMPILER_VERSION)
      set(_version " ${CMAKE_D_COMPILER_VERSION}")
    else()
      set(_version "")
    endif()
    message(STATUS "The D compiler identification is "
      "${CMAKE_D_COMPILER_ID}${_version}")
  else()
    message(STATUS "The D compiler identification is unknown")
  endif()
endif()

include(CMakeFindBinUtils)

# configure variables set in this file for fast reload later on
# TODO: fix path for upstream
configure_file(cmake/Modules/CMakeDCompiler.cmake.in
  ${CMAKE_PLATFORM_INFO_DIR}/CMakeDCompiler.cmake
  @ONLY
  )

unset(__CMAKE_D_COMPILER_NAME)