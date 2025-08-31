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
* States:
  - Unprocessed - not yet processed by the event loop
  - Uncompleted (pending)- processed but not yet finished. No value or error yet
  - Completed with value of the expected type - async operation succeeded, a result is available
  - Completed with error - async operation failed, an error/exception is available





07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth




current time 7:24:20
*/


import 'dart:async';

void main(List<String> args) {
  print('Start'); // Synchronous code, executes immediately

  Future(() => 1).then(print);
  Future(() => Future(() => 2)).then(print);

  Future.delayed(const Duration(seconds: 1), () => 3).then(print);
  Future.delayed(const Duration(seconds: 1), () => Future(() => 4)).then(print);

  Future.value(5).then(print);
  Future.value(Future(() => 6)).then(print);

  Future.sync(() => 7).then(print);
  Future.sync(() => Future(() => 8)).then(print);

  Future.microtask(() => 9).then(print);
  Future.microtask(() => Future(() => 10)).then(print);

  Future(() => 11).then(print);
  Future(() => Future(() => 12)).then(print);

  print('End'); // Synchronous code, executes immediately
}
