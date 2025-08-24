//! Classes

//! Instance Methods
//* They are normal functions serving specific purposes in a class

//! Operators
//* Instance methods with special names

import 'dart:math';

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  //* Operator
  Point Operator + (Point p) => Point(x: x + p.x)

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

  final int x;
  final int y;
  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {

  var p1 = Point(x: 0, y: 0);
  var p2 = Point(x: 1, y: 1);

  // p1.distanceTo(p2);
  print('p1.distanceTo(p2) --> ${p1.distanceTo(p2)}');

}
