//! Classes

//! Constant Constructors
// Imagine if we have a cartesian coordinate system and a class to represent points with x, y coordinates
// If we create multiple points with the same coordinates, we dont want to have multiple objects representing
// them in memory. We want only 1 object for efficiency

//* We mark the constructor as const, then call it with const ConstructorName()
//* Const constructors only work with final fields
// we try to work with as many final fields as possible

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  //* For our coordinate system we can define an origin point.
  // In order to be constant it must be static
  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {

  // Either the variable or the constructor must be const, in order to create a constant object
  var p1 = const Point(x: 1, y: 1);
  const p2 = Point(x: 1, y: 1);
  // identical(p1, p2);
  print('identical(p1, p2) --> ${identical(p1, p2)}'); // now they are identical

  var listOfPoints = [
    const Point(x: 1, y: 1),
    const Point(x: 2, y: 2),
  ];

  //* the 2 below objects are the same
  var listOfPoints1 = const[
    Point(x: 1, y: 1),
    Point(x: 2, y: 2),
  ];

  const listOfPoints2 = [
    Point(x: 1, y: 1),
    Point(x: 2, y: 2),
  ];

  print(identical(listOfPoints, listOfPoints1)); // false
  print(identical(listOfPoints1, listOfPoints2)); // true
}
