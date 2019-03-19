#=============================================================================
# Find WEBP library
#=============================================================================
# Find the native WEBP headers and libraries.
#
#  WEBP_INCLUDE_DIRS - where to find WEBP/decode.h, etc.
#  WEBP_LIBRARIES    - List of libraries when using WEBP.
#  WEBP_FOUND        - True if WEBP is found.
#=============================================================================

unset(WEBP_FOUND)

# Look for the target.
# find_package(3rdParty REQUIRED COMPONENTS opencv_libwebp)
find_library(opencv_libwebp OPTIONAL)
if(opencv_libwebp_FOUND)
    get_target_property(WEBP_LIBRARY opencv_libwebp OUTPUT_NAME)
    get_target_property(WEBP_INCLUDE_DIR opencv_libwebp LIBRARY_OUTPUT_DIRECTORY)

    MARK_AS_ADVANCED(WEBP_LIBRARY)
    MARK_AS_ADVANCED(WEBP_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set WEBP_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(WEBP DEFAULT_MSG WEBP_LIBRARY WEBP_INCLUDE_DIR)

    SET(WEBP_LIBRARIES ${WEBP_LIBRARY})
    SET(WEBP_INCLUDE_DIRS ${WEBP_INCLUDE_DIR})
endif()
