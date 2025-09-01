/*
! Asynchronous Workflow (continued 4) - Timestamp 7:50:00

! Streams
* stream<T>
Streams can return 0, 1 or multiple values in the future.
The difference between Stream and Iterable is that
stream values are returned asynchronously one by one in the future

* .listen -> similar to .then on Futures




*/


import 'dart:async';
void main(List<String> args) {

  print('start');
  
  //? Emits values from 0 to infinite with 1 second delay each
  Stream.periodic(const Duration(seconds: 1), (x) => x) //? 0 1 2 3 4 5 ...
    .listen(print);

  print('end');
}
