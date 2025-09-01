/*
! Asynchronous Workflow (continued 6) - Timestamp 7:57:40

! Streams / StreamController / StreamSubscription (continued 3)

? How do we know exactly when a value will come down the stream?


current 7:58:00
*/

import 'dart:async';
void main(List<String> args) {

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

}
