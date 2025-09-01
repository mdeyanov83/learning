/*
! Asynchronous Workflow (continued 6) - Timestamp 7:57:40

! Streams / StreamController / StreamSubscription (continued 3)

? How do we know exactly when a value will come down the stream?

! async vs async* functions
* sync - used for functions that return a single result
  Declaration: Future<T> functionName() async { ... }
  Can use await inside to pause until a future completes
  Returns a single future that completes when the function finishes
* async* - for functions that return multiple values over time, i.e. a Stream

* await - used for a single future result
* await for - used

current 7:58:00
*/

import 'dart:async';
void main(List<String> args) async {

  final StreamController streamController = StreamController<int>.broadcast();

  // final streamSubscription = streamController.stream.listen(print);

  var value = 0;

  Timer.periodic(const Duration(seconds: 1), (timer) {

    if (value == 5) {
      timer.cancel();
      streamController.close();
      // streamSubscription.cancel();

    } else {
      streamController.add(value++);
    }
  });

  var max = 0;

  await for (final value in streamController.stream) {
    max = (value > max) ? value : max;
  }
  // We can do the same with .forEach
  // await stream


  print('Max is --> $max');

}
