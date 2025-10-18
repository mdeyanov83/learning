/*
! Asynchronous Workflow (continued 2) - Timestamp 7:39:30

! Futures (continues, 2nd example)

* scheduleMicrotask - schedules a void callback to run in the microtask queue
  - It does NOT return a Future
  - You canNOT 'await' it or attach .then(...)
  - It's just "fire-and-forget"

* Chained .then methods after a Future execute immediately after the Future resolves
? If a chained .then() returns a Future, subsequent chained methods execute once that Future resolves
*/

//! MICRO: 14 9 2
//* EVENT: 3(1sec delay) 13 10(F(11).print 12) 4(print 5, print 6, M(7), print 8)
//? Output: 1 15 2 9 14 4 5 6 8 7 10 13 11 12 3

import 'dart:async';

void main(List<String> args) {
  print('1');
  scheduleMicrotask(() => print('2'));

  Future.delayed(const Duration(seconds: 1), () => print('3'));

  // chained .then methods will execute immediately after the F(4) resolves
  // by the event loop
  Future(() => print('4')).then((_) => print('5')).then((_) {
    print('6');
    scheduleMicrotask(() => print('7'));
  }).then((_) => print('8'));

  scheduleMicrotask(() => print('9'));

  // chained .then will execute once F(10) resolves by the event loop
  // The .then(print 12) will only execute, once the F(11) returned by
  // the previous .then is resolved
  Future(() => print('10'))
    .then((_) => Future(() => print('11')))
    .then((_) => print('12'));

  Future(() => print('13'));
  scheduleMicrotask(() => print('14'));
  print('15');
}



