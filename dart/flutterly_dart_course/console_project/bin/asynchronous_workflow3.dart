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

! Await Mechanics
1. You call an "async" function -> it immediately returns a Future (even before hitting await)
2. When execution reaches an await someFuture; :
  - if someFuture is already completed:
    -> execution continues in the microtask queue (so it resumes before event-queue tasks)
  - if someFuture is not completed yet:
    -> Dart suspends the async function, returns control to the event loop.
    -> When the future completes, a continuation (the "rest of the async function")
      is scheduled in the microtask queue

* Always returns a future: An async function itself returns a Future<T>
* Suspension point: Code after await is put on hold and resumes later.
* Resumption uses microtasks: When a future completes, await resumes the
  * async function in the microtask queue, ensuring the continuation
  * happens before the next event task.
* Error propagation: if the awaited future completes with an error,
  * that error is re-thrown at the await point (so you can catch it with try/catch)

? await is syntactic sugar for
? “pause this async function until the future completes,
? then continue execution in a microtask”.

* await == .then(...) under the hood
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

