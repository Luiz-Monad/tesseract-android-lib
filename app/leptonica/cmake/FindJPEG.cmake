#=============================================================================
# Find JPEG library
#=============================================================================
# Find the native JPEG headers and libraries.
#
#  JPEG_INCLUDE_DIRS - where to find JPEG/decode.h, etc.
#  JPEG_LIBRARIES    - List of libraries when using JPEG.
#  JPEG_FOUND        - True if JPEG is found.
#=============================================================================

unset(JPEG_FOUND)

# Look for the target.
find_library(opencv_libjpeg OPTIONAL)
get_target_property(JPEG_INCLUDE_DIR opencv_libjpeg INCLUDE_DIRECTORIES)
get_target_property(JPEG_LIBRARY opencv_libjpeg OUTPUT_NAME)

if(JPEG_INCLUDE_DIR)
    MARK_AS_ADVANCED(JPEG_LIBRARY)
    MARK_AS_ADVANCED(JPEG_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set JPEG_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(JPEG DEFAULT_MSG JPEG_LIBRARY JPEG_INCLUDE_DIR)

    SET(JPEG_LIBRARIES ${JPEG_LIBRARY})
    SET(JPEG_INCLUDE_DIRS ${JPEG_INCLUDE_DIR})
endif()
