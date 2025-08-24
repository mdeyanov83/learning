//! Classes II // timestamp 5:00:00

//! Inheritance // 5:01:00
//* Everything you create is an object instantiated from a class
//* Every class you create will inherit, by default from the topmost class, the OBJECT class
// Every class ClassName extends Object {}, without implicitly defining it
// keyword extends = means inherits

//! Inheritance - implies sharing of behavior from a class to another one
//* if one class extends another, all fields/methods from the second will be available in the first


class Animal {
  final String name;
  // Constructor
  Animal({required this.name});

  void whatAmI() => print('I\'m an animal');
}

class Bird extends Animal {


}


void main(List<String> args) {

}
