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


 List<int> list = [1, 2, 3];

void main(List<String> args) {

}
