/*
! Asynchronous Workflow (continued 3) - Timestamp 7:44:30

! Futures (continued, back to 1st example)






07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth
Current - 7:44:30
*/

import 'dart:async';

void main(List<String> args) {
  late final int a;

  print('Start');

  Future(() => 1).then(print);
  Future(() => Future(() => 2)).then(print);

  Future.delayed(const Duration(seconds: 1), () => 3).then(print);
  Future.delayed(const Duration(seconds: 1), () => Future(() => 4)).then(print);

  Future.value(5).then(print);
  Future.value(Future(() => 6)).then(print);

  Future.sync(() => 7).then(print);
  Future.sync(() => Future(() => 8)).then(print);

  Future.microtask(() => 9).then(print);
  Future.microtask(() => Future(() => 10)).then(print);

  Future(() => 11).then(print);
  Future(() => Future(() => 12)).then(print);

  print('End');
}
