/*
! Synchronous Workflow

07:05:00 - (21) Dart Synchronous Workflows
07:09:01 - (21.1) Iterables and Lists
07:20:00

* Synchronous operation - a task that needs to be completed before moving on to the next one
  A task or function in a synchronous operation usually returns a result (a value, a type, class, etc.)
  When we want the result to consist of 0 or multiple values --> return an Iterable collection of values

* Iterable - an abstract collection of values
  - Lazily constructed - it will generate its items only when an element is accessed
  - Traversed with the help of an iterator(curr, nextItem())

------------ |  1 value  | 0 or more values
------------------------------------------
synchronous  |     T     |   ITERABLE<T> |
------------------------------------------
asynchronous | Future<T> |   STREAM<T>   |





*/

void main(List<String> args) {

}
