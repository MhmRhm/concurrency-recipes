#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

bool is_prime(size_t n) {
  if (n < 2)
    return false;
  if (n % 2 == 0)
    return n == 2;
  for (size_t d{3}; d * d <= n; d += 2)
    if (n % d == 0)
      return false;
  return true;
}

void worker(size_t start, size_t end, vector<bool> &isPrimeFlags) {
  for (size_t i{start}; i < end; i += 1)
    isPrimeFlags[i] = is_prime(i);
}

int main() {
  const size_t totalCount{1'000};
  const size_t threadCount{thread::hardware_concurrency()};

  vector<bool> isPrimeFlags{};
  isPrimeFlags.resize(totalCount, false);

  vector<jthread> threads{};
  threads.reserve(threadCount);

  {
    ScopedTimer timer{"computation"};

    size_t chunk_size{totalCount / threadCount};
    for (size_t t{}; t < threadCount - 1; t += 1)
      threads.emplace_back(worker, t * chunk_size, (t + 1) * chunk_size,
                           ref(isPrimeFlags));
    threads.emplace_back(worker, (threadCount - 1) * chunk_size, totalCount,
                         ref(isPrimeFlags));
  }

  // {
  //   ScopedTimer timer{"single-threaded computation"};

  //   for (size_t i{}; i < totalCount; i += 1)
  //     isPrimeFlags[i] = is_prime(i);
  // }

  size_t prime_count{static_cast<size_t>(
      std::count(isPrimeFlags.begin(), isPrimeFlags.end(), true))};
  cout << format("Found {} primes below {}", prime_count, totalCount) << endl;
  return 0;
}
