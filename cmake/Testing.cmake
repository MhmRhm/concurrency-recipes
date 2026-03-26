enable_testing()

find_package(GTest CONFIG REQUIRED)

include(GoogleTest)
include(Boost)
include(Coverage)
include(Memcheck)

macro(AddGTests target)
	AddCoverage(${target})
	target_link_libraries(${target}
		PRIVATE GTest::gtest
		PRIVATE GTest::gtest_main
		PRIVATE GTest::gmock
		PRIVATE GTest::gmock_main
	)
	gtest_discover_tests(${target})
	AddMemcheck(${target})
endmacro()

macro(AddBoostTests target)
	AddCoverage(${target})
	target_link_libraries(${target} PRIVATE Boost::unit_test_framework)
	add_test(NAME "${target}" COMMAND ${target}) # All tests run as one
	AddMemcheck(${target})
endmacro()

macro(AddTestResources target RES_DIR)
	set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${RES_DIR})
	set(DST_DIR  $<TARGET_FILE_DIR:${target}>/${RES_DIR})

	file(GLOB_RECURSE RESOURCE_FILES CONFIGURE_DEPENDS
		${SRC_DIR}/*
	)
	set(STAMP_FILE
		${CMAKE_CURRENT_BINARY_DIR}/${target}_${RES_DIR}.stamp
	)

	add_custom_command(
		OUTPUT ${STAMP_FILE}
		COMMAND ${CMAKE_COMMAND} -E remove_directory ${DST_DIR}
		COMMAND ${CMAKE_COMMAND} -E copy_directory ${SRC_DIR} ${DST_DIR}
		COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_FILE}
		DEPENDS ${RESOURCE_FILES}
	)
	add_custom_target(${target}_${RES_DIR}
		DEPENDS ${STAMP_FILE}
	)
	add_dependencies(${target} ${target}_${RES_DIR})
endmacro()
