#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void doSomeWork() { this_thread::sleep_for(100ms); }

void doAllWork(bool &isStopRequested, steady_clock::duration duration) {
  ScopedTimer timer{};

  auto end = steady_clock::now() + duration;
  while (steady_clock::now() < end && !isStopRequested) {
    doSomeWork();
  }
}

int main() {
  bool isStopRequested = false;
  thread workThread{doAllWork, std::ref(isStopRequested), 5s};

  this_thread::sleep_for(1s);
  isStopRequested = true;

  workThread.join();
}
