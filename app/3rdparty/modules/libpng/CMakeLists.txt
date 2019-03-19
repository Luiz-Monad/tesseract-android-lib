# ----------------------------------------------------------------------------
#  CMake file for libpng. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
set(PNG_LIBRARY libpng)
set(the_description "The ${PNG_LIBRARY}")
ocv_add_module(${PNG_LIBRARY} OPTIONAL)

if(NOT WIN32)
  find_library(M_LIBRARY
    NAMES m
    PATHS /usr/lib /usr/local/lib
  )
  if(NOT M_LIBRARY)
    message(STATUS "math lib 'libm' not found; floating point support disabled")
  endif()
else()
  # not needed on windows
  set(M_LIBRARY "")
endif()

ocv_module_include_directories(${ZLIB_INCLUDE_DIRS})

file(GLOB lib_srcs *.c)
file(GLOB lib_hdrs *.h)


if(ENABLE_NEON)
  list(APPEND lib_srcs arm/arm_init.c arm/filter_neon.S arm/filter_neon_intrinsics.c)
  add_definitions(-DPNG_ARM_NEON_OPT=2)
elseif(AARCH64)
  add_definitions(-DPNG_ARM_NEON_OPT=0) # NEON assembler is not supported
endif()

if(ENABLE_SSE
    AND (NOT MSVC OR (MSVC_VERSION GREATER 1799))) # MSVS2013+ (issue #7232)
  list(APPEND lib_srcs contrib/intel/intel_init.c contrib/intel/filter_sse2_intrinsics.c)
  add_definitions(-DPNG_INTEL_SSE)
endif()

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

if(MSVC)
  add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
endif(MSVC)

ocv_set_module_sources(SOURCES ${lib_srcs} HEADERS ${lib_hdrs})

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
  endif()
endif()

ocv_warnings_disable(CMAKE_C_FLAGS -Wcast-align)

ocv_create_module(${ZLIB_LIBRARIES})
