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
class A {
  // A(); //! constructor in just a header form, no body

  A(
    int p,  // parameters
    int a,
    int b,
    int c,
    int d,
    int e,
    int f,
  ) : 
  {
    _private = p;
    a = a;
    b = b;
    c = c;
    d = d;
    e = e;
    f = f;
  }

  int? _private; // private field

  int? a;
  int b = 1;

  final int c = 2;

  late int d;
  late final int e;
  late final int f = 5;

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

  var alfa = A(1, 2, 3, 4, 5, 6, 7);

  alfa.d = 12;
  alfa.e = 13;

  // print('alfa._private --> ${alfa._private}');
  // print('alfa.a --> ${alfa.a}');
  // print('alfa.b --> ${alfa.b}');
  // print('alfa.c --> ${alfa.c}');
  // print('alfa.d --> ${alfa.d}');
  // print('alfa.e --> ${alfa.e}');
  // print('alfa.f --> ${alfa.f}');

  // print('A.g --> ${A.g}');

  // A.h = 7;
  // print('A.h --> ${A.h}');
  // print('A.i --> ${A.i}');

  // A.j = 9;
  // print('A.j --> ${A.j}');
  // print('A.k --> ${A.k}');

  print(alfa);

}
