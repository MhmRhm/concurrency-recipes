add_executable(simple_work_in_thread main.cpp)

target_compile_options(simple_work_in_thread
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(simple_work_in_thread
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(simple_work_in_thread
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(simple_work_in_thread .)
AddCppcheck(simple_work_in_thread)
