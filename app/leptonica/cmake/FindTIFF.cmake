#=============================================================================
# Find TIFF library
#=============================================================================
# Find the native TIFF headers and libraries.
#
#  TIFF_INCLUDE_DIRS - where to find TIFF/decode.h, etc.
#  TIFF_LIBRARIES    - List of libraries when using TIFF.
#  TIFF_FOUND        - True if TIFF is found.
#=============================================================================

unset(TIFF_FOUND)

# Look for the target.
find_library(opencv_libtiff OPTIONAL)
get_target_property(TIFF_INCLUDE_DIR opencv_libtiff INCLUDE_DIRECTORIES)
get_target_property(TIFF_LIBRARY opencv_libtiff OUTPUT_NAME)

if(TIFF_INCLUDE_DIR)
    MARK_AS_ADVANCED(TIFF_LIBRARY)
    MARK_AS_ADVANCED(TIFF_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set TIFF_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(TIFF DEFAULT_MSG TIFF_LIBRARY TIFF_INCLUDE_DIR)

    SET(TIFF_LIBRARIES ${TIFF_LIBRARY})
    SET(TIFF_INCLUDE_DIRS ${TIFF_INCLUDE_DIR})
endif()
