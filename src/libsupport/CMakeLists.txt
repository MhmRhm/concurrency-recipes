add_library(libsupport_interface INTERFACE)
target_include_directories(libsupport_interface
	INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
	INTERFACE "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
target_link_libraries(libsupport_interface
	INTERFACE precompiled
)

add_library(libsupport_obj OBJECT
	libsupport.cpp
)
target_compile_options(libsupport_obj
	PRIVATE "${DEFAULT_CXX_COMPILE_FLAGS}"
	PRIVATE "${DEFAULT_CXX_OPTIMIZE_FLAG}"
)
target_link_libraries(libsupport_obj
	PUBLIC libsupport_interface
)
set_target_properties(libsupport_obj PROPERTIES
	POSITION_INDEPENDENT_CODE 1
)

add_library(libsupport_shared SHARED
	$<TARGET_OBJECTS:libsupport_obj>
)
set_target_properties(libsupport_shared PROPERTIES
	PREFIX "lib"
	VERSION "${PROJECT_VERSION}"
	SOVERSION "${PROJECT_VERSION_MAJOR}"
	OUTPUT_NAME "support$<$<CONFIG:Debug>:d>"
)
target_link_libraries(libsupport_shared
	PUBLIC libsupport_interface
)

add_library(libsupport_static STATIC
	$<TARGET_OBJECTS:libsupport_obj>
)
set_target_properties(libsupport_static PROPERTIES
	PREFIX "lib"
	OUTPUT_NAME "support$<$<CONFIG:Debug>:d>"
)
target_link_libraries(libsupport_static
	PUBLIC libsupport_interface
)

Format(libsupport_static .)
AddCppcheck(libsupport_static)
