//! Classes II // timestamp 5:00:00

//! Inheritance // 5:01:00
//* Everything you create is an object instantiated from a class
//* Every class you create will inherit, by default from the topmost class, the OBJECT class
// Every class ClassName extends Object {}, without implicitly defining it
// keyword extends = means inherits

//! Inheritance - implies sharing of behavior from a class to another one
//* if one class extends another, all fields/methods from the second(base) will be available in the first
// that includes the constructor of the base class
//* class Bird extends Animal{}
//* Animal → the base class (also called superclass or parent class)
//* Bird → the derived class (also called subclass or child class)





// currently at 5:03:00

class Animal {
  final String name;
  // Constructor
  Animal({required this.name});

  void whatAmI() => print('I\'m an animal');
}

class Bird extends Animal {
  Bird(String name) : super(name: name);

}


void main(List<String> args) {

}
