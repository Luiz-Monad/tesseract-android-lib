#=============================================================================
# Find JP2K library
#=============================================================================
# Find the native JP2K headers and libraries.
#
#  JP2K_INCLUDE_DIRS - where to find JP2K/decode.h, etc.
#  JP2K_LIBRARIES    - List of libraries when using JP2K.
#  JP2K_FOUND        - True if JP2K is found.
#=============================================================================

unset(JP2K_FOUND)

# Look for the target.
# find_package(3rdParty REQUIRED COMPONENTS opencv_libjasper)
find_library(opencv_libjasper REQUIRED)
if(opencv_libjasper_FOUND)
    get_target_property(JP2K_LIBRARY opencv_libjasper OUTPUT_NAME)
    get_target_property(JP2K_INCLUDE_DIR opencv_libjasper LIBRARY_OUTPUT_DIRECTORY)

    MARK_AS_ADVANCED(JP2K_LIBRARY)
    MARK_AS_ADVANCED(JP2K_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set JP2K_FOUND to TRUE if
    # all listed variables are TRUE
    INCLUDE(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(JP2K DEFAULT_MSG JP2K_LIBRARY JP2K_INCLUDE_DIR)

    SET(JP2K_LIBRARIES ${JP2K_LIBRARY})
    SET(JP2K_INCLUDE_DIRS ${JP2K_INCLUDE_DIR})
endif()
