# ----------------------------------------------------------------------------
#  CMake file for libjasper. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
set(JASPER_LIBRARY libjasper)
set(the_description "The ${JASPER_LIBRARY}")
ocv_add_module(${JASPER_LIBRARY} OPTIONAL)

add_definitions(-DEXCLUDE_MIF_SUPPORT -DEXCLUDE_PNM_SUPPORT -DEXCLUDE_BMP_SUPPORT -DEXCLUDE_RAS_SUPPORT  -DEXCLUDE_JPG_SUPPORT -DEXCLUDE_PGX_SUPPORT)

ocv_module_include_directories()

file(GLOB lib_srcs *.c)
file(GLOB lib_hdrs *.h)
file(GLOB lib_ext_hdrs jasper/*.h)

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

ocv_set_module_sources(SOURCES ${lib_srcs} HEADERS ${lib_hdrs} ${lib_ext_hdrs})

if(WIN32 AND NOT MINGW)
  add_definitions(-DJAS_WIN_MSVC_BUILD)
endif(WIN32 AND NOT MINGW)

ocv_warnings_disable(CMAKE_C_FLAGS -Wno-implicit-function-declaration -Wno-uninitialized -Wmissing-prototypes
                                   -Wno-unused-but-set-parameter -Wmissing-declarations -Wunused -Wshadow
                                   -Wsign-compare -Wstrict-overflow)
ocv_warnings_disable(CMAKE_C_FLAGS -Wunused-parameter) # clang
ocv_warnings_disable(CMAKE_C_FLAGS /wd4013 /wd4018 /wd4101 /wd4244 /wd4267 /wd4715) # vs2005

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
  endif()
endif()

ocv_create_module()

install(FILES ${lib_ext_hdrs} OPTIONAL DESTINATION "${CMAKE_CURRENT_BINARY_DIR}" COMPONENT libs)
