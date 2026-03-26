include(CMakePackageConfigHelpers)

install(
	TARGETS precompiled libsee_interface libsee_static libsee_shared
	EXPORT libsee-targets
)
install(DIRECTORY src/libsee/include/libsee
	DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
	FILES_MATCHING PATTERN "*.h"
)
install(
	EXPORT libsee-targets
	NAMESPACE see::
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/libsee"
)

add_library(see::precompiled ALIAS precompiled)
add_library(see::libsee_interface ALIAS libsee_interface)
add_library(see::libsee_static ALIAS libsee_static)
add_library(see::libsee_shared ALIAS libsee_shared)

export(
	TARGETS precompiled libsee_interface libsee_static libsee_shared
	NAMESPACE see::
	FILE "${PROJECT_BINARY_DIR}/libsee-targets.cmake"
)

configure_package_config_file(
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/libsee-config.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/cmake/libsee-config.cmake"
	INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/libsee"
	PATH_VARS CMAKE_INSTALL_INCLUDEDIR
)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/cmake/libsee-config-version.cmake"
	VERSION "${PROJECT_VERSION}"
	COMPATIBILITY SameMajorVersion
)
install(
	FILES
	"${CMAKE_CURRENT_BINARY_DIR}/cmake/libsee-config.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/cmake/libsee-config-version.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/libsee"
)

install(TARGETS see)

set(CPACK_PACKAGE_CONTACT "Mohammad Rahimi <https://github.com/MhmRhm>")
set(CPACK_PACKAGE_DESCRIPTION "SeeMake: a CMake project template.")
include(CPack)
