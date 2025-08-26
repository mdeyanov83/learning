/*
! Generics - timestamp 5:33:00
* Generic types - <K, V> - this <> angle bracket declaration marks the class or method as being generic
*1. What is the purpose of using generics?
*2. How can we use them to enhance the quality of our code?

! Naming convention - most often single capital letter
? collections
* abstract class List<E>    - <E> = elements
* abstract class Set<E>     - <E> = elements
* abstract class HashSet<E> - <E> = elements (part of the dart:collection library)
? maps
* abstract class Map<K, V>  - <K, V> = keys and values

* static List<T> castFrom<S, T>(List<S> source) - <T> = type, <S> = source
* List<R> cast<R>();        - <R> = return
Sometimes, single letters may not be clear enough for readability, therefore you can use any name you want
* abstract class Bloc<Event, State>




*/

class Tuple {
  // make parameters private
  final int? _a;
  final int? _b;
  final int? _c;

  // basic constructor
  const Tuple(this._a, this._b, this._c);
  // named constructor, private fields assigned in the initializer list
  Tuple.fromList(List<int> list) :
    // checking if an index of a list exists (can be simplified by checking list.length)
    _a = list.asMap().containsKey(0) ? list[0] : null,
    _b = list.asMap().containsKey(1) ? list[1] : null,
    _c = list.asMap().containsKey(2) ? list[2] : null;

  // getters for first, second and third element
  int? get first => _a;
  int? get second => _b;
  int? get third => _c;


}

void main(List<String> args) {
  Tuple tuple = const Tuple(1, 2, 3);

}
