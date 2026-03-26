include_guard(GLOBAL)

add_library(precompiled INTERFACE)

target_precompile_headers(precompiled INTERFACE
	<memory>
	<functional>
	<algorithm>
	<stdexcept>

	<chrono>
	<source_location>

	<string>
	<string_view>
	<format>
	<regex>

	<iostream>
	<syncstream>
	<fstream>
	<sstream>
	<filesystem>

	<array>
	<vector>
	<list>
	<queue>
	<set>
	<map>
	<unordered_map>

	<thread>
	<mutex>
	<semaphore>

	<cstddef>
	<cstdint>
)
