/*
! Introduction to Synchronous and Asynchronous workflow

! Isolates
06:41:00 - (20) Dart Isolates Explained (Sync & Async Chapter)
06:50:11 - (20.1) Dart Isolate Structure, Event Queue, Event Loop, Single Thread, Memory
06:57:50 - (20.2) Parallelism
!06:59:00 - (20.3) Isolate Groups
07:00:41 - (20.4) Microtask queue

* Isolate - Independent unit of execution in Dart
  - Isolated memory spaces: Each isolate has its own memory heap
  - No shared memory: Isolates, cannot directly access each other's memory
  - Its own event loop and event queue
  - Message passing: Communication happens through message passing
  - No race condition: Since there's no shared state, you avoid typical threading issues
  - Single thread: Each isolate runs on a single thread

* Main isolate - the main() function

! Isolate structure - each isolate contains:
  1. Heap (memory space) - its own objects and variables
  2. Event loop - processes events/tasks one at a time
  3. Event queue - holds events/messages waiting to be executed
  4. Ports - used for inter-isolate communication:
    - ReceivePort -> listens for messages
    - SendPort -> sends messages to another isolate
  5. Event handler - The function (code) tied to an event, which actually runs

! Event Queue - each isolate has its own event queue
  * Events are:
    - Messages from other isolates
    - I/O events (e.g., file read, HTTP request completion)
    - Microtasks (higher priority tasks like Future.then() callbacks)
  * Types of queues inside an isolate:
    1. Microtask Queue -> higher priority, runs first
    2. Event Queue -> runs after all microtasks are drained

! Event Loop
  The event loop is the scheduler inside each isolate that decides what to run next
  1. Pick a task from the microtask queue (if available)
  2. If microtasks are empty, pick from the event queue
  3. Repeat forever

! Parallelism
Running multiple isolates at the same time on different CPU cores(threads)
  - Dart is single-threaded per isolate, so within 1 isolate, there is no
    parallel execution - only concurrency (tasks are interleaved using the event loop)
  - If you spin up multiple isolates, Dart can use multiple cores(threads)
    to execute them in parallel
  - Communication between isolates is done with message passing (SendPort / ReceivePort)

! Event Groups
TODO

! Microtask Queue
* Microtask - a small, high-priority async task that Dart schedules to run
  







*/

import 'dart:math';
void main(List<String> args) {

  print('#1 - sqrt(4) -> ${sqrt(4)}');
  print('#2 - multiply(51, 10) => ${15 * 10}');
  print('#3 - sum(20, 5) -> ${20 + 5}');
  Future.delayed(const Duration(seconds: 5),
    () => print('#4 - multiply(4, 3) -> ${4 * 3}')); // Future.delayed

  print('#5 - difference (20, 5) -> ${20 - 5}');


}
