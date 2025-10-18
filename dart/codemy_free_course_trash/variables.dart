void main() {
  // Variables
  // Declaration using var, dynamic, const, final
  // or using actual data types

  // Strings
  // var name = "John";
  String name = "John";

  // Integer
  var x = 41;
  // x = "asdf";
  // int x = 41;

  // Dynamic - variable type is not known until runtime and can be reassigned different types
  // Used when working with data from an API, or when data type is unknown at compile-time
  // Data type can be changed during runtime
  dynamic firstName = "Tim";

  // Constant - defined datatype and value at compile time
  const String fullName = "John Elder";

  // Final - defined datatype at compile-time, value can be assigned at runtime, cannot be reassigned.
  final String nickName = "test nick";

  // declaring and not using - value is null
  var myName;

  print(name);
  print(x);

  print(firstName);
  print(fullName);
  print(nickName);

  print(myName);
}
