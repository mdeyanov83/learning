//! Classes
// So far all out constructors return an instance of their class

//! Factory Constructors // 5:52:00 timestamp
//* defined with the keyword 'factory'
// factory ClassName.constructorName()

//* Don’t have an initializer list.
//* Can return new or existing instances.
//* Can return instance of a subclass.
//* Can perform custom logic before returning an object
//! Don NOT have access to 'this.' keyword, therefore cannot initialize fields
//* explicitly return something

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


  final int x;
  final int y;
  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {


}
