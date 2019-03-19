# ----------------------------------------------------------------------------
#  CMake file for libwebp. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
set(WEBP_LIBRARY libwebp)
set(the_description "The ${WEBP_LIBRARY}")
ocv_add_module(${WEBP_LIBRARY} OPTIONAL)

ocv_module_include_directories("${CMAKE_CURRENT_SOURCE_DIR}/cpu-features")

file(GLOB lib_srcs dec/*.c dsp/*.c enc/*.c mux/*.c utils/*.c webp/*.c)
file(GLOB lib_hdrs dec/*.h dsp/*.h enc/*.h mux/*.h utils/*.h webp/*.h)

# FIXIT
if(ANDROID AND ARMEABI_V7A AND NOT NEON)
  foreach(file ${lib_srcs})
    if("${file}" MATCHES "_neon.c")
      set_source_files_properties("${file}" COMPILE_FLAGS "-mfpu=neon")
    endif()
  endforeach()
endif()

file(GLOB cpuf_s cpu-features/*.c)
file(GLOB cpuf_h cpu-features/*.h)

if(ANDROID)
  set(lib_srcs ${lib_srcs} ${cpuf_s})
  set(lib_hdrs ${lib_hdrs} ${cpuf_h})
endif()

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

add_definitions(-DWEBP_USE_THREAD)

ocv_set_module_sources(SOURCES ${lib_srcs} HEADERS ${lib_hdrs})

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
  endif()
endif()

ocv_warnings_disable(CMAKE_C_FLAGS -Wunused-variable -Wunused-function -Wshadow -Wmaybe-uninitialized)
ocv_warnings_disable(CMAKE_C_FLAGS /wd4244 /wd4267) # vs2005

ocv_create_module(${ZLIB_LIBRARIES})
