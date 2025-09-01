/*
! Asynchronous Workflow (continued 2) - Timestamp 7:39:30

! Futures (continues, 2nd example)

* scheduleMicrotask - schedules a void callback to run in the microtask queue
  - It does NOT return a Future
  - You canNOT 'await' it or attach .then(...)
  - It's just "fire-and-forget"



07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth
Current - 7:39:50
*/


import 'dart:async';

void main(List<String> args) {

  print('1');
  scheduleMicrotask(() => print('2'));

  Future.delayed(const Duration(seconds: 1), () => print('3'));

  Future(() => print('4')).then((_) => print('5')).then((_) {
    print('6');
    scheduleMicrotask(() => print('7'));
  }).then((_) => print('8'));

  scheduleMicrotask(() => print('9'));

  Future(() => print('10'))
    .then((_) => Future(() => print('11')))
    .then((_) => print('12'));

  Future(() => print('13'));
  scheduleMicrotask(() => print('14'));
  print('15');
}


//! MICRO:
//* EVENT:

//: Processing:

//? Output: 1 15 2 9 14 4 5 6 8 7 10 12 13 11 3
