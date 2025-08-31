/*
! Synchronous Workflow

07:05:00 - (21) Dart Synchronous Workflows
07:09:01 - (21.1) Iterables and Lists
07:20:00

* Synchronous operation - a task that needs to be completed before moving on to the next one
  A task or function in a synchronous operation usually returns a result (a value, a type, class, etc.)
  When we want the result to consist of 0 or multiple values --> return an Iterable collection of values

* Iterable - an abstract collection of values
  - Iterable class - Iterable<type>
  - Lazily constructed - it will generate its items only when an element is accessed
  - Traversed with the help of an iterator(curr, nextItem()) -
  The iterator is a helper containing the current element and a function that will let it advance
  to the next element
  - It doesn't need to have a specified length
  - Accessing an element will regenerate all elements until the desired one is found
  - Looping through an iterable, you cannot use an ordinary "for" statement
  - use "for in" or .forEach

? List - non lazy type of iterable --> constructed as soon as it's called
  - Has a defined size
  - Items are stored at a specific index (so does not need to have an iterator, since all values
    have their own index and can be accessed directly)

`            |  1 value  |   multiple   |
------------------------------------------
synchronous  |     T     |  ITERABLE<T> |
------------------------------------------
asynchronous | Future<T> |  STREAM<T>   |

! Creating Iterables
  * Mark with the 'sync*' keyword between the function parameter list () and function body {}

*1. Iterables are lazy-loaded - the generator function runs only when an element inside the iterable is accessed
*2. Iterables generate only the right number of elements needed, they don't continue past the value we are looking for.


*/

void main(List<String> args) {
  // final a = showNormal(10); // The function runs and prints its output as it should, then returns a List assigned to a

  final a = showGenerator(10); // We assign the iterable, but the generator does not run until accessed

  // The iterable is generated only when accessed
  // runs through the code and finally the accessed element is printed
  print(a.last);
  print(a.first);
  print(a.elementAt(4));

  // Examples
  final list = a.toList(); // generates a list from the iterable
  print('list[3] -> ${list[3]}');

  final list1 = [1, 2, 3, 4, 5, 6, 7];
  final evenList = list1.where((element) => element.isEven); // evenList is of class Iterable<int>
  print(evenList.elementAt(2));

  // creating an instance of an iterable directly, using the generate constructor
  final iterable = Iterable<int>.generate(3);
  print('iterable.elementAt(1) --> ${iterable.elementAt(1)}');

}

// generate synchronously a single value
int sum(int a, int b) => a + b;

// Normal function generating a list
List<int> showNormal(int n) {
  print('Normal started');
  final list = <int>[];
  for (var i = 1; i <= n; i++) {
    print('i -> $i');
    list.add(i);
  }
  print('Normal ended');
  return list;
}

// Synchronous generator function generating a collection
Iterable<int> showGenerator(int n) sync* {
  print('Generator started');
  for (var i = 1; i <= n; i++) {
    print('i -> $i');
    yield i;
  }
  print('Generator ended');
}

Iterable<int> showNegativeGenerator(int n) sync* {
  print('Negative Generator started');
  for (var i = 1; i <= n; i++) {
    print('i -> $i');
    yield i;
  }
  print('Negative Generator ended');
}
