//! Classes 2

//! ABSTRACTION
//* Abstract classes, Abstract methods, Interfaces

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
  Duck(String name) : super(name);

  @override
  void whatAmI() => print('I\'m a duck!');

  void swim() {}
}


void main(List<String> args) {

}
