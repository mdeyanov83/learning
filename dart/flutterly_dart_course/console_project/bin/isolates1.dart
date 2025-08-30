/*
! Introduction to Synchronous and Asynchronous workflow

! Isolates
06:41:00 - (20) Dart Isolates Explained (Sync & Async Chapter)
06:50:11 - (20.1) Dart Isolate Structure, Event Queue, Event Loop, Single Thread, Memory
06:57:50 - (20.2) Parallelism
06:59:00 - (20.3) Isolate Groups
07:00:41 - (20.4) Microtask queue

* Isolate - the component in which the Dart code runs




*/

import 'dart:math';
void main(List<String> args) {

  print('#1 - sqrt(4) -> ${sqrt(4)}');
  print('#2 - multiply(51, 10) => ${15 * 10}');
  print('#3 - sum(20, 5) -> ${20 + 5}');
  Future.delayed(const Duration(seconds: 5),
    () => print('#4 - multiply(4, 3) -> ${4 * 3}')); // Future.delayed

  print('#5 - difference (20, 5) -> ${20 - 5}');


}
