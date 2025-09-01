/*
! Asynchronous Workflow (continued 3) - Timestamp 7:44:30

! Futures (continued 3)






07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth
Current - 7:44:30
7:48:55
*/

import 'dart:async';

void main(List<String> args) async {
  late final int a;

  print('Start');

  // Future(() => 1).then((value) => a = value);
  // // print(a); //! Throws LateInitializationError, because the Future has not completed yet, therefor 'a' is not initialized
  // Timer(Duration(seconds: 1), () {
  //   print('one second delay');
  //   print('Print(a) -> $a');
  // });

  // awaits for the future to complete then assigns its value to 'a' and continues
  // Both examples below are the same, but with different syntax

  // await Future(() => 1).then((value) => a = value);
  a = await Future(() => 1);

  // print('Print(a) -> $a');


  print('End');
}
