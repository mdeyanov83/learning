//! Classes

//! Factory Constructors
// So far all out constructors return an instance of their class



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
