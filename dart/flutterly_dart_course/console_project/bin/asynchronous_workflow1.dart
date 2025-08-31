/*
! Asynchronous Workflow - timestamp - 7:20:00
? What is an Asynchronous operation - A task that that needs to be solved
? But doesn't need to wait before proceeding to the next one
`            |  1 value  |   multiple   |
------------------------------------------
synchronous  |     T     |  ITERABLE<T> |
------------------------------------------
asynchronous | Future<T> |  STREAM<T>   |

Future<T> - A single value, that will be calculated and retrieved later
Stream<T> - emit multiple values Asynchronously, while other tasks are executed in the background

! FUTURES
(Single async result)
* States:
  - Unprocessed - not yet processed by the event loop
  - Uncompleted (pending)- processed but not yet finished. No value or error yet
  - Completed with value of the expected type - The async operation succeeded, a result is available
  - Completed with error - 






07:20:00 - (22) Dart Asynchronous Workflows
07:22:51 - (22.1) Futures in-depth
07:50:31 - (22.2) Streams in-depth

*/


void main(List<String> args) {

}
