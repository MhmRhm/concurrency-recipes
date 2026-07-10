add_executable(large_shared_work main.cpp)

target_compile_options(large_shared_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(large_shared_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(large_shared_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(large_shared_work .)
AddCppcheck(large_shared_work)
