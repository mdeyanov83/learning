/*
! Asynchronous Workflow (continued 4) - Timestamp 7:50:00

! Streams
* stream<T>
Streams can return 0, 1 or multiple values in the future.
The difference between Stream and Iterable is that
stream values are returned asynchronously one by one in the future

* .listen -> similar to .then on Futures

! StreamController
? A StreamController is like a pipeline or manager for a stream. It lets you:
  * Create a stream that can emit multiple values over time
  * Add data, errors, or signal completion.
  * Control whether multiple listeners are allowed (single-distribution or broadcast)

* Basic properties:
  .stream - The actual stream object consumers can listen to
  .sink.add(value) - Add a new value event to the stream
  .sink.addError(error) - Add an error event to the stream
  .close() - Signal that no more events will come
  .broadcast(); - multiple listeners

Example:
import 'dart:async';
void main() {
  var controller = StreamController<int>();
  // Consumer listens to the stream
  controller.stream.listen((value) => print('Data: $value'));
  // Emit some events
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.close(); // end of stream
}

Output:
Data: 1
Data: 2
Data: 3

* The controller is the producer side, the stream is the consumer side
* Can be single-subscription or broadcast
  StreamController.broadcast(); // multiple listeners


! StreamSubscription
? When you listen to a stream, you get a StreamSubscription object. It lets you:
  * Pause, resume, or cancel the subscription
  * Handle events (onData, onError, onDone) in a more granular way

Exmaple



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
