#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void countIterations(stop_token stopToken, size_t &totalIterations) {
  size_t localCount{};

  while (!stopToken.stop_requested()) {
    localCount += 1;
    totalIterations += 1;
  }

  cout << format("Thread {} iterated {} times.", this_thread::get_id(),
                 localCount)
       << endl;
}

int main() {
  vector<size_t> totalIterations{};
  totalIterations.resize(4);

  {
    vector<jthread> threads{};
    for (size_t i{}; i < 4; i += 1)
      threads.emplace_back(countIterations, ref(totalIterations[i]));

    this_thread::sleep_for(2s);
  }

  auto total = accumulate(totalIterations.begin(), totalIterations.end(), 0);
  cout << format("Iterated {} times total.", total) << endl;
}
