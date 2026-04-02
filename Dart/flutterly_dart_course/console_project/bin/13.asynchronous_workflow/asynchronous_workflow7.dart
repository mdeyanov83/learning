/*
! Asynchronous Workflow (continued 7) - Timestamp 7:59:30

! Streams / StreamController / StreamSubscription (continued 4)

* Creating a Stream by using an async* generator function
*/


void main(List<String> args) {
  asyncGenerator().listen(print);
}

var negativeStream = Stream<int>.periodic(const Duration(milliseconds: 500), (x) => -x);

Stream<int> asyncGenerator() async* {
  for (var i = 0; i < 5; i++) {
    // Delaying emitting of each value
    await Future<void>.delayed(const Duration(seconds: 1));
    yield i;
  }
  // yield another stream within the stream
  yield* negativeStream;
}
