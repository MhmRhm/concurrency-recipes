#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void doSomeWork() { this_thread::sleep_for(100ms); }

void doAllWork() {
  ScopedTimer timer{};

  auto end = steady_clock::now() + 5s;
  while (steady_clock::now() < end) {
    doSomeWork();
  }
}

int main() { doAllWork(); }
