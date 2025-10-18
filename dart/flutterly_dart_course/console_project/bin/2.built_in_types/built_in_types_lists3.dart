void main(List<String> arguments) {

  //! . - dot operator and
  //! ?. - null aware dot operator
  //! !. - bang operator - null assertion operator

  //! . - dot operator(dot notation) used to access properties (class fields)
  //! and methods of an object
  int a1 = 4;
  int? b1 = null;
  print(a1.isEven);

  //! ?. - null aware dot operator - access the filed / methods only when the caller is not null
  print(b1?.isEven); // returns null, because b is null and does not call the method

  //! !. - null assertion operator - tells the compiler to trust that the caller is not null
  // print(b1!.isEven); // will throw an error, because b is null


  //! CHAINING methods

  //! . - dot operator - calls a method and returns its actual return value
  //! Used when you need the result of a method/property
  //! Example: .reversed .map() .toList() - all return new objects

  //! .. - cascade operator - calls a method, but discards its return value, instead it gives back the original object.
  //! Used when methods return void
  //! Example: .addAll() .sort() - all return void

  //! ?.. - null aware cascade operator

  // Instead of this
  List<int> list1 = [1, 0, 2];
  list1.sort();
  list1 = list1.reversed.toList();
  list1.addAll([5, 3, 4]);
  list1.sort();
  list1 = list1.map((e) => e + 1).toList();
  print(list1);

  // You can use cascade operator like this.
  List<int> list2 = (([1, 0, 2]..sort()).reversed.toList()
    ..addAll([5, 3, 4])
    ..sort())
    .map((e) => e + 1).toList();
  print(list2);

  //! ... - spread operator - spreads all elements of a collection (iterable)
  //! ...? - null aware spread operator (notice the ? is at the end of the ...)
  var a = [1, 2, 3];
  // var b = [3, 4, 5];
  var b = null;
  var c = [...a, ...?b];
  print(c);

}
