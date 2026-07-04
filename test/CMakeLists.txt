if (NOT see_BUILD_TESTS)
  return()
endif()

include(Testing)

add_subdirectory(libsee)
add_subdirectory(see)
