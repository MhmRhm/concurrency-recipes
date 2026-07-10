#pragma once

class ScopedTimer {
public:
  ScopedTimer(const std::string &fn_name =
                  std::source_location::current().function_name());
  ~ScopedTimer();

private:
  std::string m_functionName{};
  std::chrono::high_resolution_clock::time_point m_startTime{};
};
