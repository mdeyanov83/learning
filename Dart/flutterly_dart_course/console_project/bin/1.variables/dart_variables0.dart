//! Variables

//! 4 types of variables: top-level, static, instance, local
// depends on where you declare them

//! top-level - global. declared outside of any function or class
// can be accessed from anywhere

//! static - declared inside a class using the 'static'keyword
// shared by all objects(instances) of the class (only 1 copy in memory) and belong to the class itself
// accessed using class reference

//! instance - (field/property) declared inside a class, but outside of methods or constructors
// each object(instance) of the class gets its own copy, and their values can be different for each object
// accessed using object reference
// both are defined inside a class,


//! local - defined inside a function
// accessed only within the scope of this function


//! top level variable
int t = 5;
int? nullableTopLevel; // can be left unassigned at declaration (will have null value)
// int nonNullableTopLevel = 5; // must be assigned a value on declaration
late int nonNullableTopLevel; // by using 'late' modifier keyword, you can assign a value later, only if you are sure it will happen before accessing the variable


class A {
  //! static variable
  static int s = 12; // can be accessed without instantiating an object from the class. The variable belongs to the class itself
  static int? nullableStatic; // can be left unassigned (will have null value)
  // static int nonNullableStatic = 15; // must be assigned a value on declaration
  static late int nonNullableStatic; // by using 'late' you can assign a value later, but before it is accessed

  //! instance variable
  double i = 25;
  double? nullableInstance; // can be left unassigned at declaration (will have null)
  late double nonNullableInstance; // can be assigned here by = 30; or or lef unassigned and assigned in the constructor initialization list

  A({ // class constructor
    required this.i,
    // required this.nullableInstance, // you can assign in the constructor as well
    // required this.nonNullableInstance, // can be assigned in the constructor as well

  }) : nullableInstance = 30//, nonNullableInstance = 30 // you can assign into the initialization list
  { // constructor body
    nullableInstance = 30; // also can assign in the constructor body
    nonNullableInstance = 50; // can be assigned in the constructor body, ONLY if you use 'late' upon declaration
  }
}

void randomFunction() {
  //! local variable, only available inside the scope of the function
  var l = 4;

  int? nullableLocal; // can be left unassigned at declaration (will have null value)
  nullableLocal = 5;

  int nonNullableLocal; // local non nullable CAN be left unassigned at declaration, but must be assigned before usage
  // late modifier is not needed for local variables
  nonNullableLocal = 5;
}


void main(List<String> args) {
  nullableTopLevel = 5; // assigning a value to a nullable top-level variable

  nonNullableTopLevel = 10; // assigning a value to a 'late' declared top level variable

  A.nonNullableStatic = 15; // assigning a value to a late declared non nullable static variable

  A.nullableStatic = 15; // assign a value to nullable static variable

  var alfa = A(i: 10)..nullableInstance = 20; // assign a value to nullable instance variable after the constructor
  print(alfa.nullableInstance);

  print(A.s); // accessing the static variable

  var beta = A(i:20)..nonNullableInstance = 30; // assign a value to non nullable instance variable after the constructor
  print(beta.nonNullableInstance);
}
