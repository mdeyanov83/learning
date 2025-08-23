//! Classes - Instance Variables and Methods
// Instance variables <-> also referred as Fields
// recommended to explicitly specify the types of fields inside of class

//! How to access and initialize the class fields without a constructor method
//! Rule #1
//! Any fields you create inside a class will have a default getter method automatically generated

//! private fields - prefixed with _
// private identifier (variable, method, class, etc.) is library-private
// That means: it’s only accessible within the same Dart library (file, or group of files imported together as a library).
// Outside, it can be access/modified via the getter and setter methods (if any)

//! Rule #2
//! Any non-final fields & late final fields will have a default setter method
// normal final fields cannot be set outside the class, can only be set via constructors

//! 95% of time only standard final fields are used inside a class

class A {
  int? _private; // private field

  int? a;
  int b = 1;

  final int c = 2;

  late int d;
  late final int e;
  late final int f = 5;

  static int g = 6;
  static late int h;
  static late int i = 8; // lazy initialization, in this case pointless
  static late final int j;

  static const int k = 10;
}

void main(List<String> args) {

  var alfa = A();

  // Rule 1 - accessing vie the dot . operator (the default getter function)
  print('alfa._private --> ${alfa._private}');
  print('alfa.a --> ${alfa.a}');
  print('alfa.b --> ${alfa.b}');
  print('alfa.c --> ${alfa.c}');
  alfa.d = 3; // otherwise d is late and not assigned a value -> Unhandled exception
  print('alfa.d --> ${alfa.d}');
  alfa.e = 4; // same, but can only be set once, as it is final
  // alfa.e = 7; //! unhandled exception
  print('alfa.e --> ${alfa.e}');
  // alfa.f = 10; //! compile error, final and already assigned
  print('alfa.f --> ${alfa.f}');

  print('A.g --> ${A.g}');

  A.h = 7;
  print('A.h --> ${A.h}');
  print('A.i --> ${A.i}');

  A.j = 9;
  print('A.j --> ${A.j}');
  print('A.k --> ${A.k}');

}
