/*
! Asynchronous Workflow (continued 5) - Timestamp 7:53:00

! Streams / StreamController / StreamSubscription (continued 2)


current 7:54:00
*/

import 'dart:async';
void main(List<String> args) {

  // Initialize the StreamController as a broadcast stream (multiple listeners supported)
  final StreamController streamController = StreamController<int>.broadcast();

  // Initialize the StreamSubscription (.listen) and print received values
  // streamController.stream.listen((value) => print('Data: $value'));
  final streamSubscription = streamController.stream.listen(print); // same as above line

  // Initialize a second StreamSubscription
  final otherStreamSubscription = streamController.stream.listen((value) => print('Second *2: ${value*2}'));

  var value = 0;
  // Adding values to the stream
  Timer.periodic(const Duration(seconds: 1), (timer) {

    // Cancel everything once value reaches 5
    if (value == 5) {
      timer.cancel();
      streamController.close();
      streamSubscription.cancel();
    } else {
      streamController.add(value++);
    }
  });


}
