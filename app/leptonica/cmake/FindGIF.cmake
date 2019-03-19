#=============================================================================
# Find GIF library
#=============================================================================
# Find the native GIF headers and libraries.
#
#  GIF_INCLUDE_DIRS - where to find GIF/decode.h, etc.
#  GIF_LIBRARIES    - List of libraries when using GIF.
#  GIF_FOUND        - True if GIF is found.
#=============================================================================

unset(GIF_FOUND)

# Look for the target.
# find_package(3rdParty REQUIRED COMPONENTS opencv_libgif)
find_library(opencv_libgif REQUIRED)
if(opencv_libgif_FOUND)
    get_target_property(GIF_LIBRARY opencv_libgif OUTPUT_NAME)
    get_target_property(GIF_INCLUDE_DIR opencv_libgif LIBRARY_OUTPUT_DIRECTORY)

    MARK_AS_ADVANCED(GIF_LIBRARY)
    MARK_AS_ADVANCED(GIF_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set GIF_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(GIF DEFAULT_MSG GIF_LIBRARY GIF_INCLUDE_DIR)

    SET(GIF_LIBRARIES ${GIF_LIBRARY})
    SET(GIF_INCLUDE_DIRS ${GIF_INCLUDE_DIR})
endif()
