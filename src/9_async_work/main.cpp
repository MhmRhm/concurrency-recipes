#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void doSomeWork() { this_thread::sleep_for(100ms); }

bool doAllWork(steady_clock::duration duration) {
  ScopedTimer timer{};

  auto end = steady_clock::now() + duration;
  while (steady_clock::now() < end) {
    doSomeWork();
  }

  return true;
}

int main() {
  // Launch compute() asynchronously
  auto future = async(launch::async, doAllWork, 5s);

  cout << "Doing other work...\n";

  // Wait for the result and retrieve it
  auto result = future.get();

  cout << "Result: " << result << "\n";
  return 0;
}
