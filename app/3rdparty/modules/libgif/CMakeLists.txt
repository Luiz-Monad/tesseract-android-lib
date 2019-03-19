# ----------------------------------------------------------------------------
#  CMake file for libgif. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
set(GIF_LIBRARY libgif)
set(the_description "The ${GIF_LIBRARY}")
ocv_add_module(${GIF_LIBRARY} OPTIONAL)

include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckIncludeFiles)

check_include_file(dlfcn.h HAVE_DLFCN_H)
check_include_file(fcntl.h HAVE_FCNTL_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(limits.h HAVE_LIMITS_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(stdarg.h HAVE_STDARG_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(strings.h HAVE_STRINGS_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_files("dlfcn.h;stdint.h;stddef.h;inttypes.h;stdlib.h;strings.h;string.h;float.h" StandardHeadersExist)
if(StandardHeadersExist)
check_function_exists(memchr memchrExists)
  if(memchrExists)
  check_function_exists(free freeExists)
    if(freeExists)
      message(STATUS "ANSI C header files - found")
      set(STDC_HEADERS 1 CACHE INTERNAL "System has ANSI C header files")
    endif()
  endif()    
endif()

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmakein"
               "${CMAKE_CURRENT_BINARY_DIR}/gif_config.h" @ONLY)

ocv_module_include_directories(${ZLIB_INCLUDE_DIRS})

file(GLOB lib_srcs *.c)
file(GLOB lib_hdrs *.h)
set(lib_ext_hdrs "${CMAKE_CURRENT_BINARY_DIR}/gif_config.h")

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

ocv_set_module_sources(SOURCES ${lib_srcs} HEADERS ${lib_hdrs} ${lib_ext_hdrs})

if(WIN32 AND NOT MINGW)
  add_definitions(-DGIF_WIN_MSVC_BUILD)
endif(WIN32 AND NOT MINGW)

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
  endif()
endif()

ocv_create_module()

