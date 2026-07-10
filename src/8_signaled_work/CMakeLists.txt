add_executable(signaled_work main.cpp)

target_compile_options(signaled_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(signaled_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(signaled_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(signaled_work .)
AddCppcheck(signaled_work)
