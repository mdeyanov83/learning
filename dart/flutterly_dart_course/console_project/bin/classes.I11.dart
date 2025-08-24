//! Classes

//! Static Methods
//* Similar to static fields, static methods exist without needing to instantiate any object from that class
//* As a result - static methods can interact with static fields inside a class



import 'dart:math';

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  //! Static methods
  static distanceBetween(Point p1, Point p2) {
    var dx = p1.x - p2.x;
    var dy = p1.y - p2.y;
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }


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

  //? Implicit getters (invisible)
  final int x;
  // int get x => x;

  final int y;
  // int get y => y;

  //? additional getters
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

  // p1.sum;
  print('p1.sum --> ${p1.sum}');
  // p1.diff;
  print('p1.diff --> ${p1.diff}');
}
