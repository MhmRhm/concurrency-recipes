add_executable(async_work main.cpp)

target_compile_options(async_work
	PRIVATE ${DEFAULT_CXX_COMPILE_FLAGS}
	PRIVATE ${DEFAULT_CXX_OPTIMIZE_FLAG}
)
target_include_directories(async_work
	PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(async_work
	PRIVATE precompiled
	PRIVATE libsupport_static
)
Format(async_work .)
AddCppcheck(async_work)
