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

// this. is a keyword used to access fields inside a class and used
// when there is ambiguity between parameter and field names
// final variables, must be unassigned in declaration, since we initialize them in the constructor

class A {
  //! Constructor example 1
  //* Initializing in the constructor body, which is generally not recommended
  //* Unassign the normal final variables, since we are not initializing them at declaration
  //* c field - standard non-nullable, non-late, final field, must be assigned before the constructor's body -> initializer list
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

  //! Constructor example 2
  //* initialize all fields in the initializer list
  //* remove the constructor's body (used for additional logic or setting other fields,
    //* besides ones in the parameter list, but when they require validation or additional logic)
  // A(
  //   int p,
  //   int x,
  //   int b,
  //   int c,
  //   int d,
  //   int e,
  //   int f,
  // ) : _private = p,
  //     a = x,
  //     this.b = b,
  //     this.c = c,
  //     this.d = d,
  //     this.e = e,
  //     this.f = f;

  //! Constructor example 3
  //* Syntactic sugar regarding the fields you need to set inside the constructor of a class
  //* Enumerate all the fields we want to initialize inside the parameters body
  //* note that we can also initialize other fields inside the initializer list based on our parameter list
  //* we can also do that in the constructor body if we require any additional logic
  // A(
  //   this._private,
  //   this.a,
  //   this.b,
  //   this.c,
  //   // this.d,
  //   this.e,
  //   this.f,
  // ) : d = b // d is initialized with the value of b from the parameter list
  // {
  //   d = b; // we can also do it in the constructor body
  // }

  //! Constructor example 4
  //* Switching the parameter list to named parameters using { } block
  //* since all named parameters are optional by default, so final and non-nullable parameters must
  //* be prefixed by 'required' or must be provided a default value '= 5'
  //* _private fields - cannot be named, therefore must be listed
  //* before the named parameter { } block, as positional parameters

  A(
    this._private,{
    this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
  });

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

  //* override the default print(classInstance) method - toString, for easier fields output
  @override
  String toString() =>
    'A(_private: $_private, a: $a, b: $b, c:, $c, d: $d, e: $e, f: $f)';
}

void main(List<String> args) {

  // alfa.d = 12;
  // alfa.e = 13;

  // var alfa = A(1, 2, 3, 4, 5, 6, 7); // Constructor example 1 and 2
  // var alfa = A(1, 2, 3, 4, 5, 6); // Example 3

  var alfa = A(
    1,
    a: 2,
    b: 3,
    c: 4,
    d: 5,
    e: 6,
    f: 7,
  ); // Example 4

  print(alfa);
}

