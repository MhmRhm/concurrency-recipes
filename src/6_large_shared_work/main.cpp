#include "libsupport/libsupport.h"

using namespace std;
using namespace chrono;

void produce(stop_token stopToken, queue<int> &taskList) {
  while (!stopToken.stop_requested()) {
    if (taskList.size() < 100) {
      taskList.push(0);
    }
  }
}

void consume(stop_token stopToken, queue<int> &taskList) {
  while (!stopToken.stop_requested()) {
    if (taskList.size()) {
      taskList.pop();
    }
  }
}

int main() {
  queue<int> taskList{};

  {
    jthread producer{produce, ref(taskList)};
    jthread consumer{consume, ref(taskList)};
    this_thread::sleep_for(2s);
  }

  cout << format("Remaining tasks: {}", taskList.size()) << endl;
}
