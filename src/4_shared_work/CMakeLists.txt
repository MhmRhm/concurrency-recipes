add_executable(shared_work main.cpp)

target_compile_options(shared_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(shared_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(shared_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(shared_work .)
AddCppcheck(shared_work)
