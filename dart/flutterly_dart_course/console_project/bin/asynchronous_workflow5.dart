/*
! Asynchronous Workflow (continued 5) - Timestamp 7:53:00

! Streams / StreamController / StreamSubscription (continued 2)


current 7:54:00
*/

import 'dart:async';
void main(List<String> args) {

  // Initialize the StreamController
  final StreamController streamController = StreamController<int>();

  var value = 0;

  // Adding values to the stream
  Timer.periodic(const Duration(seconds: 1), (timer) {
    streamController.add(value++);
  });

  // 
  streamController.stream.listen(print);
}
