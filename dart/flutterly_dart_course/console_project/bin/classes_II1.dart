//! Classes II // timestamp 5:00:00

//! Inheritance // 5:01:00
//* Everything you create is an object instantiated from a class
//* Every class you create will inherit, by default from the topmost class, the OBJECT class
// Every class ClassName extends Object {}, without implicitly defining it
// keyword extends = means inherits
//* a class can ONLY extend a SINGLE class!!!
// Class Hierarchy - class Bird extends Animal, Animal extends Object, therefore Bird extends Object too

//! Inheritance - implies sharing of behavior from a class to another one
//* if one class extends another, all fields/methods from the second(base) will be available in the first
// that includes the constructor of the base class
//* class Bird extends Animal{}
//* Animal → the base class (also called superclass or parent class)
//* Bird → the derived class (also called subclass or child class)

//! super(...) keyword
//! The subclass constructor must call a superclass constructor (either explicitly or implicitly).
//! it is called by calling ': super(...)' in the subclass initializer list
//! The call to super(...) happens before the body of the subclass constructor.
//* super keyword - can also access the superclass methods or properties (useful when overriding)


//! Polymorphism - concept of taking a method with the same name from inside the base class
//! and override it to perform specific behavior

//! covariant - keyword
//* Normally, when overriding a method, you cannot narrow parameter types, Dart requires the parameter
//* types to stay compatible with the base class.
//* covariant - lets you explicitly override a parameter with a subtype

class Animal {
  final String name;
  // Constructor
  Animal({required this.name});
  // Named constructor
  // Animal.fromJson() : name = 'Jerry';

  void whatAmI() => print('I\'m an animal');
  void chase(Animal a) {}
}

class Mouse extends Animal {
  Mouse (): super(name: 'Jerry');
}

//* Example: covariant override
class Cat extends Animal {
  Cat() : super(name: 'Tom');
  @override // override the Animal.chase method to take in a Mouse, instead of Animal
  // void chase(Mouse m) {} // Error, due to requirement for parameters to stay compatible with e base type
  void chase(covariant Mouse m) {} // with 'covariant' this rule is relaxed, and we can explicitly override the parameter type
}

//* class hierarchy - Bird extends Animal, Animal extends Object
class Bird extends Animal {
  Bird(String name) : super(name: name); //* denotes the superclass default Animal constructor
  // Bird.fromJson(String name) : super.fromJson(); //* we can call named superclass constructors too
}

class Duck extends Bird {
  Duck(String name) : super(name); //* we only call super(name) because Bird constructor does not take named parameters

  @override
  void whatAmI() => print('I\'m a duck!'); //* polymorphism

  void swim() {}
}


void main(List<String> args) {
  Duck duck = Duck('Munchkin');

  print('duck.name --> ${duck.name}'); //* duck can access the .name field all the way from the Animal class

  duck.whatAmI(); // 'I'm a duck!' - overridden from the superclass

}
