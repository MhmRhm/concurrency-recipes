#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

class SharedQueue {
public:
  size_t size() {
    lock_guard<mutex> lock{m_mutex};
    return m_queue.size();
  }

  void push(int value) {
    lock_guard<mutex> lock{m_mutex};
    m_queue.push(value);
    m_cv.notify_one();
  }

  int pop() {
    unique_lock<mutex> lock{m_mutex};
    m_cv.wait(lock, [this] { return !m_queue.empty(); });
    auto value = m_queue.front();
    m_queue.pop();
    return value;
  }

private:
  queue<int> m_queue{};
  mutex m_mutex{};
  condition_variable m_cv{};
};

void produce(stop_token st, SharedQueue &q) {
  while (!st.stop_requested()) {
    if (q.size() < 1'000'000) {
      q.push(0);
    }
  }
}

void consume(stop_token st, SharedQueue &q) {
  while (!st.stop_requested()) {
    if (q.size()) {
      q.pop();
    }
  }
}

int main() {
  SharedQueue q;

  {
    jthread producer(produce, ref(q));
    jthread consumer(consume, ref(q));
    this_thread::sleep_for(2s);
  }

  cout << format("Remaining tasks: {}", q.size()) << endl;
}
