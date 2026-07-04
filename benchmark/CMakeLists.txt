if (NOT see_BUILD_BENCHMARKS)
  return()
endif()

include(Benchmarking)

add_subdirectory(libsee)
add_subdirectory(see)
