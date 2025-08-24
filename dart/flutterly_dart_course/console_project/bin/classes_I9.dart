//! Classes

//! Instance Methods
//* They are normal functions serving specific purposes in a class

//! Operators
//* Operators (like +, -, ==, [], >, etc.) are basically instance methods with special names
//* You can override them in the class to define a custom behavior when used with this class instance objects
//* This is called: operator overloading
//* You can only overload existing operators — you can’t invent new symbols.

//* Syntax:
// class ClassName {
//   ReturnType operator <symbol>(ParameterType other) {
//     // custom logic
//   }
// }
//* operator is the keyword.
// *<symbol> is the operator you’re overloading (+, -, [], etc.).

//! Getters and Setters
//* Whenever you access a field from a class, you are accessing a getter function
//* Cannot have the same name as the property (field) it returns
//* Usually int get x => _x;
//? See below examples in blue
//* Every class has implicit getters


import 'dart:math';

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  //* Operators - examples with shorthand arrow => syntax
  Point operator +(Point p) => Point(x: x + p.x, y: y + p.y);
  Point operator -(Point p) => Point(x: x - p.x, y: y - p.y);

  //* Instance Method
  num distanceTo(Point p) {
    var dx = x - p.x;
    var dy = y - p.y;
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }

  factory Point.random({required bool isPositive}) {
    int minNegativeValue = -99;
    int maxNegativeValue = -1;
    int minPositiveValue = 0;
    int maxPositiveValue = 99;

    int randomNegativeValue = minNegativeValue + Random().nextInt(maxNegativeValue - minNegativeValue);
    int randomPositiveValue = minPositiveValue + Random().nextInt(maxPositiveValue - minPositiveValue);

    return isPositive
      ? Point(x: randomPositiveValue, y: randomPositiveValue)
      : Point(x: randomNegativeValue, y: randomNegativeValue);
  }

  //? Implicit getters
  final int x;
  // int get xValue => x;

  final int y;
  // int get yValue => y;

  int get sum => x + y;
  int get diff => x - y;

  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {

  var p1 = Point(x: 0, y: 0);
  var p2 = Point(x: 1, y: 1);

  // p1.distanceTo(p2);
  print('p1.distanceTo(p2) --> ${p1.distanceTo(p2)}');

  // p1 + p2;
  print('p1 + p2 --> ${p1 + p2}');

  // p1 - p2;
  print('p1 - p2 --> ${p1 - p2}');

  var rP1 = Point.random(isPositive: true);
  var rP2 = Point.random(isPositive: true);
  print(rP1);
  print(rP2);
  print('rP1 + rP2 --> ${rP1 + rP2}');

}
