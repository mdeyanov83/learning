/*
! Asynchronous Workflow (continued 3) - Timestamp 7:44:30

! Futures (continued 3)

! await - keyword
* await - pauses the execution of an async function until the given future completes
  - While waiting, the Dart isolate is not blocked - the event loop can keep running other microtasks and events
  - When the awaited future completes, execution resumes, right after the 'await',
    with the result (or throws if the future completed with an error).
* 'await' can be used only in an 'async' function
  Syntax: Type functionName(args) async {body}

? await is syntactic sugar for
? “pause this async function until the future completes,
? then continue execution in a microtask”.

! Await Mechanics
1. You call an "async" function -> it immediately returns a Future (even before hitting await)
2. When execution reaches an await someFuture; :
  - if someFuture is already completed:
    -> execution continues in the microtask queue (so it resumes before event-queue tasks)
  - if someFuture is not completed yet:
    -> Dart suspends the async function, returns control to the event loop.
    -> When the future completes, a continuation (the "rest of the async function")
      is scheduled in the microtask queue





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

