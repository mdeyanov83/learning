/*
! Asynchronous Workflow (continued 6) - Timestamp 7:57:40

! Streams / StreamController / StreamSubscription (continued 3)

sync* → a synchronous generator, returns an Iterable<T>.
async → an asynchronous function, returns a Future<T>.
async* → an asynchronous generator, returns a Stream<T>.

! async vs async* functions (* is for generators - multiple values)
* async - used for functions that return a single result
  Declaration: Future<T> functionName() async { ... }
  Can use await inside to pause until a future completes
  Returns a single future that completes when the function finishes
* async* - for functions that return multiple values over time, i.e. a Stream
  Declaration: Stream<T> functionName() async* { ... }
  Uses 'yield' or 'yield*' to emit values incrementally
  Execution is suspended at 'await' and at each 'yield'
  Returns a stream that can produce many values asynchronously

  Feature     |async          |async*
  ------------------------------------
  Returns     |Future<T>      |Stream<T>
  Produces    |Single value   |Multiple values over time
  Emits values|'return'       |'yield' / 'yield*'
  Pauses exec |At 'await'     |At 'await' and at 'yield'
  Usage       |Fetch data once|Event streams, sequences, timers

? How do we know exactly when a value will come down the stream?

* await
  Used with: a single future result
  Purpose: pause execution of an async function until the future completes
  Syntax: var result = await someFuture;
  Execution resumes after the future completes, returning the value (or throwing if the future fails)
  - Works only on Futures
  - Function must be marked 'async'
  - Pauses execution at that line

* await for
  Used with: a Stream (asynchronous sequence of values)
  Purpose: Iterate over all values emitted by the stream, pausing at each event
  Syntax: await for (var item in someStream) { // process item }

current 7:58:00
*/

import 'dart:async';
void main(List<String> args) async {

  final StreamController streamController = StreamController<int>.broadcast();

  final streamSubscription = streamController.stream.listen(print);

  var value = 0;

  Timer.periodic(const Duration(seconds: 1), (timer) {

    if (value == 5) {
      timer.cancel();
      streamController.close();
      streamSubscription.cancel();

    } else {
      streamController.add(value++);
    }
  });

  var max = 0;

  // find the max value of a stream of ints
  // await for (final value in streamController.stream) {
  //   max = (value > max) ? value : max;
  // }

  // We can do the same with .forEach
  await streamController.stream.forEach((value) {
    max = (value > max) ? value : max;
  });


  print('Max is --> $max');

}
