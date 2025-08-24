//! Classes
//* Most of the time in Dart and Flutter you will have mainly a bunch of final fields, that will be initialized inside the constructor

//! Named Constructors

class A {
  A({
    required this.a,
    required this.b,
  });

  final int a;
  final int b;

  @override
  String toString() => 'A(a: $a, b: $b)';
}


void main(List<String> args) {

  var alfa = A(a: 1, b: 2);
  print(alfa);
}

