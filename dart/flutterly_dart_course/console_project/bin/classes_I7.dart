//! Classes

//! Factory Constructors // 5:52:00 timestamp
// So far all out constructors return an instance of their class

//* Don’t have an initializer list.
//* Can return new or existing instances.
//* Can return instance of a subclass.
//* Can perform custom logic before returning an object
//! Don NOT have access to this. keyword

//! Use cases:
//* Singletons
//* Caching / memoization
//* Abstract classes or interfaces (return concrete implementations)

class Point {
  const Point({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;
  static const Point origin = Point(x: 0, y: 0);

  @override
  String toString() => 'A(x: $x, y: $y)';
}

void main() {


}
