add_executable(simple_work main.cpp)

target_compile_options(simple_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(simple_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(simple_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(simple_work .)
AddCppcheck(simple_work)
