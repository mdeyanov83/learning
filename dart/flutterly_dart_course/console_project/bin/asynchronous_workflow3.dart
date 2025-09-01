/*
! Asynchronous Workflow (continued 3) - Timestamp 7:44:30

! Futures (continued 3)






07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth
Current - 7:44:30
*/

import 'dart:async';

void main(List<String> args) {
  late final int a;

  print('Start');

  // Future(() => 1).then((value) => a = value);
  // print(a); //! Throws LateInitializationError, because the Future has not completed yet, therefor 'a' is not initialized

  // awaits for the future to complete then assigns its value to 'a'
  a = await Future(() => 1);

  Duration(seconds: 1);
  print(a);

  print('End');
}
