//! Classes
// So far all out constructors return an instance of their class

//! Factory Constructors // 4:52:00 timestamp
//* defined with the keyword 'factory'
// factory ClassName.constructorName()
// the factory keyword, relaxes the constructor rules and give access to the return statement
// however, removes the access to the this. keyword, so we cannot initialize fields inside it

//* Don’t have an initializer list.
//* Can return new or existing instances.
//* Can return instance of a subclass.
//* Can perform custom logic before returning an object
//! Don NOT have access to 'this.' keyword, therefore cannot initialize fields
//* explicitly return something - the current class or an extended of the current class

//! Use cases:
//* Singletons
//* Caching / memoization
//* Abstract classes or interfaces (return concrete implementations)

import 'dart:math';

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  // Example - factory constructor generating a random point having positive or negative coordinates
  // depending on a bool parameter
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

  // Example - factory constructor returning an existing instance
  factory Point.explanation() {
    return origin;
  }

  // Example - factory constructor, returning another factory constructor
  // Using shorthand arrow syntax
  factory Point.secondExplanation() => Point.random(isPositive: true);


  final int x;
  final int y;
  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {
  var positivePoint = Point.random(isPositive: true);
  var negativePoint = Point.random(isPositive: false);

  print('randomPositive --> $positivePoint');
  print('randomNegative --> $negativePoint');
}
