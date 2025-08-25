//! Classes 2

//! ABSTRACTION
//* Abstract classes, Abstract methods, Interfaces

//* An interface is a class that contains a list of fields and methods headers


abstract class UserRepositoryInterface {
  late final List<int> usersList;
  void create();
  List<int> read();
  void update();
  void delete();
}

class UserRepository implements UserRepositoryInterface {

  
}


class Animal {
  final String name;
  Animal({required this.name});

  void whatAmI() => print('I\'m an animal');
  void chase(Animal a) {}
}

class Mouse extends Animal {
  Mouse (): super(name: 'Jerry');
}

class Cat extends Animal {
  Cat() : super(name: 'Tom');
  @override
  void chase(covariant Mouse m) {}
}

class Bird extends Animal {
  Bird(String name) : super(name: name);
}

class Duck extends Bird {
  Duck(String name) : super(name);

  @override
  void whatAmI() => print('I\'m a duck!');

  void swim() {}
}


void main(List<String> args) {

}
