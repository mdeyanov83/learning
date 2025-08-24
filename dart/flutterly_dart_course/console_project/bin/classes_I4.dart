//! Classes - Methods
// Methods -> are functions defined inside a class

//! Constructors
//! Instantiate a class object with fields values as arguments, instead of manually assigning each field value
// Constructor purpose is so that the fields inside a class can be rapidly initialized in a more organized fashion

// The method that is called when a class is instantiated into an object
// every class comes with a default constructor - a function with no name, no body and the same name as the class
// The constructor doesn't need a function body it can exist in just a header form (although may have one if necessary)
// Do not have a return type


// When instantiating a class object, the fields inside are first assigned the values provided upon declaration,
// THEN the constructor is called

// static variables cannot be set inside of a constructor, as they exist in the class itself, without an object instance

// 4:38:45 - start of constructor function parameters explanation

//! Constructor syntax

// this. is a keyword used to access fields inside a class
// final variables, must be unassigned in declaration, since we initialize them in the constructor


class A {
  //* Constructor example 1
  // A(
  //   // parameter list
  //   int p,
  //   int x,
  //   int b,
  //   int c,
  //   int d,
  //   int e,
  //   int f,
  // ) : this.c = c  // initializer list - every field can be initialized here
  // {
  //   // constructor body - usually used for additional logic
  //   _private = p;
  //   a = x; // no this.a needed, because there is no ambiguity between a and x
  //   this.b = b;
  //   this.d = d;
  //   this.e = e;
  //   this.f = f;
  // }

  //* Constructor example 2
  A(
    int p,
    int x,
    int b,
    int c,
    int d,
    int e,
    int f,
  ) : this.c = c
  {
    _private = p;
    a = x;
    this.b = b;
    this.d = d;
    this.e = e;
    this.f = f;
  }

  int? _private;
  int? a;
  int b = 1;
  final int c; // non nullable, non late final fields, must be assigned before the constructor's body
  late int d;
  late final int e;
  late final int f;

  static int g = 6;
  static late int h;
  static late int i = 8; // lazy initialization, in this case pointless
  static late final int j;
  static const int k = 10;

  @override // override the default print(classInstance) method - toString, for easier fields output
  String toString() =>
    'A(_private: $_private, a: $a, b: $b, c:, $c, d: $d, e: $e, f: $f)';
}


void main(List<String> args) {

  // alfa.d = 12;
  // alfa.e = 13;

  var alfa = A(1, 2, 3, 4, 5, 6, 7);

  print(alfa);

}

