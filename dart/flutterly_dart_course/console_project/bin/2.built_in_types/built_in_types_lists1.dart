void main(List<String> arguments) {

  //! Lists - ordered collection of non-unique objects

  List<int> list = [1, 2, 3];
  list.forEach(print);

  print('first value: ${list[0]}');
  print(list[list.length - 1]);

  List<bool> booleans = [true, false, true];
  List<A> listOfAObjects = [A(), A(), A()];

  // List<dynamic> ...
  List<num> listofIntegersAndDoubles = [2, 3.0, 5];
  print(listofIntegersAndDoubles);

  List<dynamic> complexList= [1, 2, 3.5, 'hey', true, null];
  print(complexList);

  //! Only non-nullable values
  List<Object> complexList2 = [2, 3.0, 5, 'hey ', false];
  print(complexList2);

  //! Nullable values
  List<Object?> complexList3 = [2, 3.0, 5, 'hey', true, null];
  print(complexList3);

  //! Casting - as - keyword
  var integerValue = complexList3[0] as int;
  var doubleValue = complexList3[1] as double;
  var stringValue = complexList3[3] as String;
  var booleanValue = complexList3[4] as bool;
  var nullValue = complexList3[5] as Null;

  print(integerValue.isEven);
  print(doubleValue.isInfinite);
  print(stringValue.isNotEmpty);

  List<int> a = [1, 2, 3]; //! Non-nullable list of non-nullable objects
  List<int?> b = [1, 2, null]; //! Non-nullable list of nullable objects
  List<int>? c = [3, 4, 5]; //! Nullable list of non-nullable objects
  List<int?>? d = [1, 2, null]; //! Nullable list of nullable objects

}


class A{}
