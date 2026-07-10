#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void someFunction([[maybe_unused]] unique_ptr<int> ptr) {}

void doSomeWork() { this_thread::sleep_for(100ms); }

void doAllWork(steady_clock::duration duration) {
  ScopedTimer timer{};

  auto end = steady_clock::now() + duration;
  while (steady_clock::now() < end) {
    doSomeWork();
  }
}

void doOtherWork(steady_clock::duration duration) {
  ScopedTimer timer{};

  auto end = steady_clock::now() + duration;
  while (steady_clock::now() < end) {
    doSomeWork();
  }
}

int main() {
  thread workThread{doAllWork, 5s};

  doOtherWork(3s);

  workThread.join();
}
