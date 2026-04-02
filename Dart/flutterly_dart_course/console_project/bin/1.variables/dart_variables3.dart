//! Variables

//! Declare with var, but do not assign a value
//! the inferred type will be 'dynamic', therefore later can be changed
// However, it is preferred not to do that

void main(List<String> arguments) {
  var x;  // same as dynamic x; // Compile time type is dynamic
  print(x.runtimeType); // dynamic is nullable type, so type when accessed is Null

  x = 5;
  print(x.runtimeType); // int

  x = 4.0;
  print(x.runtimeType); // double

  x = 'whatever';
  print(x.runtimeType); // String

  x = [1, 2, 3];
  print(x.runtimeType); // List<int>


  //! List of dynamic - list of different types of values
  List<dynamic> randomList = [1, "3", 5.0];
  print(randomList.runtimeType); // List<dynamic>
  print(randomList);
}
