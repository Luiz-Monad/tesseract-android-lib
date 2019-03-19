#=============================================================================
# Find PNG library
#=============================================================================
# Find the native PNG headers and libraries.
#
#  PNG_INCLUDE_DIRS - where to find PNG/decode.h, etc.
#  PNG_LIBRARIES    - List of libraries when using PNG.
#  PNG_FOUND        - True if PNG is found.
#=============================================================================

unset(PNG_FOUND)

# Look for the target.
# find_package(3rdParty REQUIRED COMPONENTS opencv_libpng)
find_library(opencv_libpng REQUIRED)
if(opencv_libpng_FOUND)
    get_target_property(PNG_LIBRARY opencv_libpng OUTPUT_NAME)
    get_target_property(PNG_INCLUDE_DIR opencv_libpng LIBRARY_OUTPUT_DIRECTORY)

    MARK_AS_ADVANCED(PNG_LIBRARY)
    MARK_AS_ADVANCED(PNG_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set PNG_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(PNG DEFAULT_MSG PNG_LIBRARY PNG_INCLUDE_DIR)

    SET(PNG_LIBRARIES ${PNG_LIBRARY})
    SET(PNG_INCLUDE_DIRS ${PNG_INCLUDE_DIR})
endif()
