find_package(protobuf CONFIG REQUIRED)

function(AddProtoLibrary TARGET_NAME)
	add_library(${TARGET_NAME} STATIC ${ARGN})

	target_link_libraries(${TARGET_NAME}
		PUBLIC protobuf::libprotobuf
	)

	set(PROTO_INC_DIR "${CMAKE_CURRENT_BINARY_DIR}/include")
	set(PROTO_OUT_DIR "${PROTO_INC_DIR}/${TARGET_NAME}")
	file(MAKE_DIRECTORY "${PROTO_OUT_DIR}")

	target_include_directories(${TARGET_NAME}
		PUBLIC "$<BUILD_INTERFACE:${PROTO_INC_DIR}>"
		PUBLIC "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
	)

	protobuf_generate(
		TARGET ${TARGET_NAME}
		PROTOC_OUT_DIR "${PROTO_OUT_DIR}"
	)
endfunction()
