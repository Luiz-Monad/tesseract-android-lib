
set(libs GIF JPEG JP2K PNG TIFF WEBP)
set(overridejp2k jasper)
foreach(LIB ${libs})
    string(TOLOWER ${LIB} llib)
    if(override${llib})
        set(llib ${override${llib}})
    endif()        
    set(TARGET opencv_lib${llib})
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/templates/FindLib.cmake.in
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Find${LIB}.cmake @ONLY)
endforeach()
