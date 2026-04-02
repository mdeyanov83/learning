/*
! Generics - timestamp 5:50:15
* Generic Types can be used inside functions and methods of a class

! If we use dynamic types instead of generic, the code is not so type-safe anymore.
* Any type can slip in and errors will be shown only at runtime, while with generics
* code will be checked for type safety on compile-time.
* With generic types - everything is type safe and errors or warnings will be detected at compile time

? When you should use generic types
* When you want to create a special collection or data structure. The collection may accept a number
of different data types, so instead of reimplementing it for every type -> use generics
* When a portion of the code is repetitive -> abstract it into a function. If it will use multiple types of data -> generics
* Some collections like String<> and Map<> already use generics

*/

//! With standard methods you need to create a separate method for each input type
// class Utils{
//   static int? getItemInt(List<int> list, int index) =>
//     list.asMap().containsKey(index) ? list[index] : null;

//   static String? getItemString(List<String> list, int index) =>
//     list.asMap().containsKey(index) ? list[index] : null;
// }

class Utils {
  //! generic method
  //* set <T> type to the List
  //* annotate getItem method as generic type with <T>
  //* mark the return type as nullable 'T' - static T?
  static T? getItem<T>(List<T> list, int index) =>
    list.asMap().containsKey(index) ? list[index] : null;
}

void main(List<String> args) {

  // Standard methods
  // var listInt = [1, 2, 3, 4];
  // var listSring = ['a', 'b'];
  // print(Utils.getItemInt(listInt, 1));
  // print(Utils.getItemString(listInt, 1));

  var list = ['a', 'b'];
  print(Utils.getItem(list, 0));

  var list1 = [1, 2, 3, 4];
  print(Utils.getItem(list1, 2));

  var list2 = ['a', 1, 3.4, Object()];
  print(Utils.getItem(list2, 3));
}
