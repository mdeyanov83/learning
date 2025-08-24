//! Classes

//! Constant Constructors
// Imagine if we have a cartesian coordinate system and a class to represent points with x, y coordinates
// If we create multiple points with the same coordinates, we dont want to have multiple objects representing
// them in memory. We want only 1 object for efficiency


class Point {
  Point({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {

  var p1 = Point(x: 1, y: 1);
  var p2 = Point(x: 1, y: 1);
  // identical(p1, p2);
  print('identical(p1, p2) --> ${identical(p1, p2)}');


}

