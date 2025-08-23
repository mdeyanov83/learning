//! Variables

//! Declaration: dynamic vs var vs final vs const
// order from least restrictive -> most restrictive

//! dynamic - can change type, can be reassigned to a new value (same type or different)
//! var - can't change type, can be reassigned to a new value (only same type)
//! final - can't change type, can't be reassigned to a new value
//! const - can't change type, can't be reassigned to a new value

//! const - not only used for variables, but also for values and constructors that will create constant values or objects
// ex: int a = const int(value: 5); -> creates a constant object in memory

//! const vs final - const variable automatically creates a constant object in memory, final variable does not




void main(List<String> arguments) {
  const int a = 5; // int a = const int(value:5);

  //! a is const, so it cannot be reassigned
  // a = 7; // error
  // a = 8; // error

  //! list is const, then it means [1,2,3] is const
  const list = [1, 2, 3];

  // ignore: lines_longer_than_80_chars
  //! if the value is const [1,2,3], it DOES NOT MEAN variable list2 is also const!
  var list2 = const [1, 2, 3];

  final b = 6;
  //! b can't be reassigned, since it's final
  // b = 7;

  //! final list3 DOES NOT MEAN [1,2,3] list is const!
  final list3 = [1, 2, 3];

  //! since [1,2,3] is not const, you can mutate its content
  list3.add(4);
  list3.add(5);

  // list3 = [4, 5, 6]; //! Error - you cannot reassign a final variable


  //! now [1,2,3] is a const list and cannot be mutated
  //! final vars will have a value known at runtime
  final list4 = const [1, 2, 3]; // const list4 = [1,2,3];

  //! const vars will have a value known at compile time
  const list5 = [1,2,3];

  // list4.add(5); //! Compiler does ot indicate an error. Error only on runtime

  print(list4.hashCode);
  print(list5.hashCode); // hash is the same for both, since they point to the same compile time const list


  final alfa = A();
  print(alfa.a);
  alfa.a = 10;
  print(alfa.a);

  // const sum = calculateSum(); //! Error, because function value will be known at runtime, cannot be assigned to a const
  final sum = calculateSum(); // fine

  var c1 = const C(list: [1, 2, 3]);
  var c2 = const C(list: [1, 2, 3]);
  print(c1.hashCode);
  print(c2.hashCode);
}

int calculateSum() => 25;

class A {
  int a = 5;
}

class B {
  static const b = 5; //! const variables within a class can only be static, not instance variables
}

class C {
  //! final list that will hold constant list
  final List<int> list;
  const C({
    required this.list
  });
}
