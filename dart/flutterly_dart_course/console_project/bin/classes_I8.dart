//! Classes

//! Singleton Pattern // timestamp 4:54:00
//* Singleton pattern of a class - a class designed to have ONLY one instance throughout the entire program
// Instead of creating multiple objects, every time you ask for the class, you get the same instance.

//* Create a class
//* The default constructor must be a 'factory' one
//* We need to return the ONLY ONE, UNIQUE instance that can exist
  // must be a _private, final, static field - since it will be only assigned once
//* the private _instance will be created via a private constructor



import 'dart:math';

class Singleton {

  Singleton._privateConstructor(); // private constructor

  static final _instance = Singleton._privateConstructor(); // private constructor creates our private instance

  factory Singleton() => _instance;

}

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
  // var positivePoint = Point.random(isPositive: true);
  // var negativePoint = Point.random(isPositive: false);

  // print('randomPositive --> $positivePoint');
  // print('randomNegative --> $negativePoint');

  var s1 = Singleton();
  var s2 = Singleton();
  print('identcal(s1, s2) --> ${identical(s1, s2)}'); // true
}
