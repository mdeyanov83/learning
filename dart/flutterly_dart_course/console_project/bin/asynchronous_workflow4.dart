/*
! Asynchronous Workflow (continued 4) - Timestamp 7:50:00

! Streams
* stream<T>
Streams can return 0, 1 or multiple values in the future.
The difference between Stream and Iterable is that
stream values are returned asynchronously one by one in the future

* .listen -> similar to .then on Futures

! StreamController
* A StreamController is like a pipeline or manager for a stream. It lets you:
  - Create a stream that can emit multiple values over time
  - Add data, errors, or signal completion.
  - Control whether multiple listeners are allowed (single-distribution or broadcast)

* Basic properties:
  .stream - The actual stream object consumers can listen to
  .sink.add(value) - Add a new value event to the stream
  .sink.addError(error) - Add an error event to the stream
  .close() - Signal that no more events will come




! StreamSubscription




*/


// import 'dart:async';
void main(List<String> args) {

  print('start');

  //? Emits values from 0 to infinite with 1 second delay each
  // Stream.periodic(const Duration(seconds: 1), (x) => x) //? 0 1 2 3 4 5 ...
  //   .listen(print);

  // Stream.periodic(const Duration(seconds: 2), (x) => -x) //? 0 -1 -2 -3 -4 -5 ...
  //   .listen(print);

  // Future.value completes first(microtask) compared to the normal future
  Stream.fromFutures([Future(() => 3), Future.value(2)]).listen(print);

  print('end');
}
