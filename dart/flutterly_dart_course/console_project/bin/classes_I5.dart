//! Classes
//* Most of the time in Dart and Flutter you will have mainly a bunch of final fields, that will be initialized inside the constructor

//! Named Constructors
// We can have multiple constructors inside a class, besides the default one
//! Named constructor
//* ClassName.constructorName()
//* Named constructors are called as a class method.
// Often named constructors are used when trying to parse JSON data into one of your classes

class A {
  A({
    required this.x,
    required this.y,
  });

  A.zero() // Named constructor
    : x = 0,
      y = 0;

  //* note that exceptions if x or y are missing from the json must be taken into account
  //* for the purpose of the tutorial bang operator ! is used for null assertion
  A.fromJson({required Map<String, int> json})
    : x = json['x']!,
      y = json['y']!;

  final int x;
  final int y;

  @override
  String toString() => 'A(x: $x, y: $y)';
}


void main(List<String> args) {

  var alfa = A(x: 1, y: 2);
  print(alfa);

  var alfaZero = A.zero(); // calling the name constructor as a class method
  print(alfaZero);

  var alfaFromJson = A.fromJson(json: {'x' : 5, 'y' : 10});
  print(alfaFromJson);

}

