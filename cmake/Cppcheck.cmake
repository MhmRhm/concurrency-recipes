include_guard(GLOBAL)

find_program(CPPCHECK_PATH cppcheck REQUIRED PATHS "${CPPCHECK_INSTALL_DIR}")

add_custom_target(cppcheck_style
	COMMAND ${CPPCHECK_PATH}
	--enable=style
	--check-level=exhaustive
	--project=${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
	--suppress=preprocessorErrorDirective:*pb.h
)

function(AddCppcheck target)
	set(CPPCHECK_ARGS
		--enable=warning,performance,portability
		--error-exitcode=1
		--inline-suppr
		--check-level=exhaustive
		--suppress=preprocessorErrorDirective:*pb.h
	)

	set_target_properties(${target}
		PROPERTIES CXX_CPPCHECK "${CPPCHECK_PATH};${CPPCHECK_ARGS}"
	)
endfunction()
