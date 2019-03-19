# ----------------------------------------------------------------------------
#  CMake file for libjpeg. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
set(JPEG_LIBRARY libjpeg)
set(the_description "The ${JPEG_LIBRARY}")
ocv_add_module(${JPEG_LIBRARY} OPTIONAL)

ocv_module_include_directories()

file(GLOB lib_srcs *.c)
file(GLOB lib_hdrs *.h)

if(ANDROID OR IOS OR APPLE)
  ocv_list_filterout(lib_srcs jmemansi.c)
else()
  ocv_list_filterout(lib_srcs jmemnobs.c)
endif()

if(WINRT)
    add_definitions(-DNO_GETENV)
    get_directory_property( DirDefs COMPILE_DEFINITIONS )
    message(STATUS "Adding NO_GETENV to compiler definitions for WINRT:")
    message(STATUS "   COMPILE_DEFINITIONS = ${DirDefs}")
endif()

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

ocv_set_module_sources(SOURCES ${lib_srcs} HEADERS ${lib_hdrs})

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
  endif()
endif()

if(CMAKE_COMPILER_IS_GNUCXX)
  set_source_files_properties(jcdctmgr.c PROPERTIES COMPILE_FLAGS "-O1")
endif()

ocv_warnings_disable(CMAKE_C_FLAGS -Wcast-align -Wshadow -Wunused)
ocv_warnings_disable(CMAKE_C_FLAGS -Wunused-parameter) # clang
ocv_warnings_disable(CMAKE_C_FLAGS /wd4013 /wd4244 /wd4267) # vs2005

ocv_create_module()
