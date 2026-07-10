add_executable(false_shared_work main.cpp)

target_compile_options(false_shared_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(false_shared_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(false_shared_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(false_shared_work .)
AddCppcheck(false_shared_work)
