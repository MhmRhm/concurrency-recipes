#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

ScopedTimer::ScopedTimer(const std::string &fn_name)
    : m_functionName(fn_name), m_startTime(high_resolution_clock::now()) {
  cout << format("In  {} - {}", m_functionName, system_clock::now()) << endl;
}
ScopedTimer::~ScopedTimer() {
  auto end_time = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(end_time - m_startTime);
  cout << format("Out {} - {} - Duration: {} us", m_functionName,
                 system_clock::now(), duration.count())
       << endl;
}
