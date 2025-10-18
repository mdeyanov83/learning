//! Classes 2

//! Mixins - timestamp 5:18:00
//* Dart only support SINGLE INHERITANCE - to avoid conflicting (same name) methods in multiple classes

//! Mixins
//* A mixin is a way to share methods and properties between classes without using traditional inheritance.
//* A class with no constructor


//! Creating mixins
//* 1. class with no constructor (functions CAN NOT be abstract, so must have a function body)
//* 2. abstract class
//* 3. declaring with 'mixin' keyword
//! 4. declaring with 'mixin class' - hybrid - Dart 3.0
  //* Can be used as a mixin and a normal class
  //* Can be extended (extend) or mixed in (with)
  //* Can be instantiated (unless made abstract)

//! Using mixin - 'with' keyword
//Note: mixins CAN be 'implement'ed, like an abstract class, reusing their API contract
//Note: mixins CAN NOT be 'extend'ed!


//* Class with no constructor
// class A {
//   void method(){}
// }

//* Abstract class
// abstract class A {
//   void method();
// }

//* Mixin, can contain both abstract and simple methods at the same time
mixin A {
  void method1();
  void method2(){}
  void method3(){}
}

//* Using mixin A, note that abstract method1 must be implemented, since there is no implementation in the mixin
class B with A{
  @override
  void method1(){}
}

void main(List<String> args) {

}
