/*
! Asynchronous Workflow - timestamp - 7:20:00
? What is an Asynchronous operation - A task that that needs to be solved
? But doesn't need to wait before proceeding to the next one
`            |  1 value  |   multiple   |
------------------------------------------
synchronous  |     T     |  ITERABLE<T> |
------------------------------------------
asynchronous | Future<T> |  STREAM<T>   |

Future<T> - A single value, that will be calculated and retrieved later
Stream<T> - emit multiple values Asynchronously, while other tasks are executed in the background

! FUTURES - timestamp 7:22:50
(Single async result)

! States:
  - Unprocessed - not yet processed by the event loop
  - Uncompleted (pending)- processed but not yet finished. No value or error yet
  - Completed with value of the expected type - async operation succeeded, a result is available
  - Completed with error - async operation failed, an error/exception is available

* Future(() => 1)
  default future constructor
  Syntax: Future(() => value);
  Event Queue

? Future(() => Future(() => 2))
  Returns another future. Dart automatically unwraps (flattens) nested futures
  Syntax: Future(() => Future(...))
  Outer future -> Event
  Inner future -> another event, once processed

* Future.delayed
  Schedules work after a delay
  Syntax: Future.delayed(Duration, callback)
  Waits Duration before execution, delayed event queue

* Future.value
  Wraps an immediate value in a future. Takes a value and resolves it immediately
  Syntax: Future.value(value)
  If value is not a future -> completes synchronously
  Completes immediately, but .then(...) runs as microtask

* Future.sync
  Takes a closure function and resolves it immediately.
  Runs the function synchronously, wraps the result in a future
  Syntax: Future.sync(callback)
  If callback returns non-future -> completes immediately
  Runs synchronously (completes immediately), but .then(...) runs as microtask

* Future.microtask
  Schedules a callback in the microtask queue
  Syntax: Future.microtask(callback)
  Callback executes as a microtask
  .then(...) also executes as a microtask









07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth

current time 7:24:20
*/


import 'dart:async';

void main(List<String> args) {
  print('Start'); // Synchronous code, executes immediately

  // Events, set on the Event Queue inside the isolate - next 4 futures
  Future(() => 1).then(print); // Default Future constructor
  Future(() => Future(() => 2)).then(print);

  Future.delayed(const Duration(seconds: 1), () => 3).then(print);
  Future.delayed(const Duration(seconds: 1), () => Future(() => 4)).then(print);

  Future.value(5).then(print); // Microtask Queue
  Future.value(Future(() => 6)).then(print); // == Future(() => 6); Unwraps immediately, placing the inner F in the Event Queue

  Future.sync(() => 7).then(print); // == Future.value(7); // Microtask Queue
  Future.sync(() => Future(() => 8)).then(print); // == Future(() => 8); // Event Queue

  Future.microtask(() => 9).then(print); // Microtask Queue
  Future.microtask(() => Future(() => 10)).then(print); // == Future (() => 10), but placed on the Microtask Queue

  Future(() => 11).then(print);
  Future(() => Future(() => 12)).then(print);

  print('End'); // Synchronous code, executes immediately
}

// Read from the Isolate Right -> Left
// Enter the Queues from the left, and push everything to the right, read from the right
// READ: End 12 11 10 9 8 7 6 5 4 3 2 1 Start
//! MICROTASK: F(10) 9 7 5
//* EVENT:  F(4) 3 10 F(12) 11 8 6 F(2) 1
// Processing: Start End 5 7 9 F(10) 1 F(2) 6 8 11 F(12) 10 2 12 3 F(4) 4
// During processing, when a Value is processed -> Printed,
// when F(Value) is processed -> it is resolved and Value is placed back on the queue
//? OUTPUT: Start End 5 7 9 1 6 8 11 10 2 12 3 4

