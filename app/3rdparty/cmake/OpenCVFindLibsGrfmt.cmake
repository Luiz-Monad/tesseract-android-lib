# ----------------------------------------------------------------------------
#  Detect 3rd-party image IO libraries
# ----------------------------------------------------------------------------

function(grfmt_get_binary_dir _result _library)
  set(${_result} ${THIRDPARTY_MODULE_thirdparty_${_library}_BINARY_DIR})
  status(grfmt_get_binary_dir ${_library} ${${_result}})
endfunction()

function(grfmt_get_source_dir _result _library)
  set(${_result} ${THIRDPARTY_MODULE_thirdparty_${_library}_LOCATION})
  status(grfmt_get_source_dir ${_library} ${${_result}})
endfunction()

function(grfmt_get_include_dir _result _library)
  set(files ${THIRDPARTY_MODULE_thirdparty_${_library}_HEADERS})
  set(${_result} "")
  foreach (f ${files})
    get_filename_component(dir ${f} DIRECTORY)
    list(INSERT ${_result} 0 ${dir})
  endforeach()
  ocv_list_unique(${_result})
  status(grfmt_get_include_dir ${_library} ${${_result}})
endfunction()

# --- zlib (required) ---

if(BUILD_ZLIB)
  ocv_clear_vars(ZLIB_FOUND)
else()
  find_package(ZLIB "${MIN_VER_ZLIB}")
  if(ZLIB_FOUND AND ANDROID)
    if(ZLIB_LIBRARIES STREQUAL "${ANDROID_SYSROOT}/usr/lib/libz.so" OR
        ZLIB_LIBRARIES STREQUAL "${ANDROID_SYSROOT}/usr/lib64/libz.so")
      set(ZLIB_LIBRARIES z)
    endif()
  endif()
endif()

if(NOT ZLIB_FOUND)
  ocv_clear_vars(ZLIB_LIBRARY ZLIB_LIBRARIES ZLIB_INCLUDE_DIRS)

  set(ZLIB_LIBRARY zlib)
  grfmt_get_binary_dir(bin_dir ${ZLIB_LIBRARY})
  grfmt_get_include_dir(inc_dir ${ZLIB_LIBRARY})
  set(ZLIB_INCLUDE_DIRS ${inc_dir} ${bin_dir})
  set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})

  list(GET ${inc_dir} 0 inc_dir)
  ocv_parse_header2(ZLIB "${inc_dir}/zlib.h" ZLIB_VERSION)
endif()
