/*
! Generics - timestamp 5:46:05
Even though you don't have to mention the <> types all the time
It is recommended to always mention them, as it will make life so much easier during debugging

*/

class RandomClass<E> {}

void main(List<String> args) {
  var listOfInts = <int>[1, 2, 3];
  var listOfStrings = <String>['a', 'b', 'c'];

  var intClass = RandomClass<int>();
  var str = RandomClass<String>();
}
