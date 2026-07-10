add_executable(latched_work main.cpp)

target_compile_options(latched_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(latched_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(latched_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(latched_work .)
AddCppcheck(latched_work)
