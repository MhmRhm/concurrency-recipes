function(EnableCoverage target_obj target_interface)
	if(CMAKE_BUILD_TYPE STREQUAL Debug)
		if(APPLE)
			target_compile_options(${target_obj}
				PRIVATE -fprofile-instr-generate -fcoverage-mapping -fno-inline)
			target_link_options(${target_interface}
				INTERFACE -fprofile-instr-generate -fcoverage-mapping)
		elseif(UNIX)
			target_compile_options(${target_obj} PRIVATE --coverage -fno-inline)
			target_link_options(${target_interface} INTERFACE --coverage)
		elseif(WIN_CLANG)
			target_compile_options(${target_obj}
				PRIVATE -fprofile-instr-generate -fcoverage-mapping -fno-inline)
			target_link_options(${target_interface}
				INTERFACE -fprofile-instr-generate -fcoverage-mapping)
		endif()
	endif()
endfunction()

function(CleanCoverage target)
	add_custom_command(TARGET ${target} PRE_BUILD COMMAND
		"$<$<PLATFORM_ID:APPLE>:find $<TARGET_FILE_DIR:${target}> -type f -name '*.profraw' -exec rm {} +>"
		"$<$<PLATFORM_ID:UNIX>:find $<TARGET_FILE_DIR:${target}> -type f -name '*.gcda' -exec rm {} +>"
		"$<$<PLATFORM_ID:WIN32>:(ls -Path $<TARGET_FILE_DIR:${target}> -Filter *.profraw -Recurse).FullName | ForEach-Object -Process {del $_}>"
	)
endfunction()

function(AddCoverage target)
	if(APPLE)
		find_program(LLVM_COV_PATH llvm-cov REQUIRED)
		find_program(LLVM_PROFDATA_PATH llvm-profdata REQUIRED)
		add_custom_target(coverage-${target}
			COMMAND ${CMAKE_COMMAND} -E chdir $<TARGET_FILE_DIR:${target}>
				$<TARGET_FILE:${target}>
			COMMAND rm -rf coverage
			COMMAND ${LLVM_PROFDATA_PATH} merge -o default.profdata
				-sparse default.profraw
			COMMAND ${LLVM_COV_PATH} show $<TARGET_FILE:${target}>
				-instr-profile=default.profdata -show-line-counts-or-regions
				-show-instantiation-summary -show-branches=count
				-use-color -format=html -output-dir=coverage-${target}
			COMMAND ${LLVM_COV_PATH} report $<TARGET_FILE:${target}>
				-show-region-summary=false -show-branch-summary=false
				-instr-profile=default.profdata
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
		)
	elseif(UNIX)
		find_program(LCOV_PATH lcov REQUIRED)
		find_program(GENHTML_PATH genhtml REQUIRED)
		add_custom_target(coverage-${target}
			COMMAND ${LCOV_PATH} -d . --zerocounters
			COMMAND ${CMAKE_COMMAND} -E chdir $<TARGET_FILE_DIR:${target}>
				$<TARGET_FILE:${target}>
			COMMAND ${LCOV_PATH} -d . --capture -o coverage.info
			COMMAND ${LCOV_PATH} -r coverage.info -o filtered.info
				"/usr/include/*" "*/vcpkg_installed/*" "*/_deps/*"
				--ignore-errors inconsistent,inconsistent
				--ignore-errors unused,unused
			COMMAND ${GENHTML_PATH} -o coverage-${target} filtered.info --legend
			COMMAND rm -rf coverage.info filtered.info
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
		)
	elseif(WIN_CLANG)
		find_program(LLVM_COV_PATH llvm-cov REQUIRED)
		find_program(LLVM_PROFDATA_PATH llvm-profdata REQUIRED)
		add_custom_target(coverage-${target}
			COMMAND ${CMAKE_COMMAND} -E chdir $<TARGET_FILE_DIR:${target}>
				$<TARGET_FILE:${target}>
			COMMAND del coverage /S /Q
			COMMAND ${LLVM_PROFDATA_PATH} merge -o default.profdata
				-sparse default.profraw
			COMMAND ${LLVM_COV_PATH} show $<TARGET_FILE:${target}>
				-show-line-counts-or-regions -show-instantiation-summary
				-show-branches=count -use-color -format=html
				-instr-profile=default.profdata -output-dir=coverage-${target}
			COMMAND ${LLVM_COV_PATH} report $<TARGET_FILE:${target}>
				-show-region-summary=false -show-branch-summary=false
				-instr-profile=default.profdata
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
		)
	endif()
endfunction()
