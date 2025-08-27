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

// class for tuple of 3 elements of type int
// class Tuple {
//   // make parameters private
//   final int? _a;
//   final int? _b;
//   final int? _c;

//   // basic constructor
//   const Tuple(this._a, this._b, this._c);
//   // named constructor, private fields assigned in the initializer list
//   Tuple.fromList(List<int> list) :
//     // checking if an index of a list exists (can be simplified by checking list.length)
//     _a = list.asMap().containsKey(0) ? list[0] : null,
//     _b = list.asMap().containsKey(1) ? list[1] : null,
//     _c = list.asMap().containsKey(2) ? list[2] : null;

//   // + and - operators, should be called only on 100% populated with int values (no null values)
//   Tuple operator +(Tuple t) => Tuple(_a! + t._a!, _b! + t._b!, _c! + t._c!);
//   Tuple operator -(Tuple t) => Tuple(_a! - t._a!, _b! - t._b!, _c! - t._c!);

//   // getters for first, second and third element
//   int? get first => _a;
//   int? get second => _b;
//   int? get third => _c;

//   // override toString method for printing
//   @override toString() => 'Tuple(first: $first, second: $second, third: $third)';
// }

// class for tuple using generics
class Tuple<E> {
  // replace int? with generic type E?
  final E? _a;
  final E? _b;
  final E? _c;

  // replace int? with generic type E?
  E? get first => _a;
  E? get second => _b;
  E? get third => _c;

  const Tuple(this._a, this._b, this._c);
  Tuple.fromList(List<E> list) :
    _a = list.asMap().containsKey(0) ? list[0] : null,
    _b = list.asMap().containsKey(1) ? list[1] : null,
    _c = list.asMap().containsKey(2) ? list[2] : null;

  // We want the + and - operators to work only for 2 tuples containing num types,
  // since only they can be added or subtracted
  //1. we declare that we return Tuple<num>
  //2. tuples sent to the operator as a parameter must also be Tuple<num>
  //3. we implement logic to check if the object we call the operator on is also of type Tuple<num>

  Tuple<num> operator +(Tuple<num> t) {

    if (this is Tuple<num>) { // check if the object calling the operator (this) is Tuple<num>
      final thisAsTupleNum = this as Tuple<num>; // type cast 'this' as Tuple<num>, because 
      return Tuple(thisAsTupleNum._a! + t._a!, thisAsTupleNum._b! + t._b!, thisAsTupleNum._c! + t._c!);
    }
    return const Tuple(0, 0, 0); // or we can throw an exception
  }


  Tuple<num> operator -(Tuple<num> t) => Tuple(_a! - t._a!, _b! - t._b!, _c! - t._c!);

  @override toString() => 'Tuple(first: $first, second: $second, third: $third)';
}

void main(List<String> args) {
  // Examples for first implementation of Tuple (for ints only)
  // Tuple tuple1 = const Tuple(1, 2, 3);
  // Tuple tuple2 = Tuple.fromList([4, 5, 6]);
  // Tuple tuple3 = Tuple.fromList([7]);
  // Tuple tuple4 = tuple1 + tuple2;
  // print('tuple1 --> $tuple1');
  // print('tuple2 --> $tuple2');
  // print('tuple3 --> $tuple3');
  // print('tuple4 --> $tuple4');

  const t1 = Tuple(1, 2, 3);
  const t2 = Tuple(4, 5, 6);
  t1 + t2; // So f



}
