//! Classes 2

//! ABSTRACTION - Abstract classes, Abstract methods, Interfaces

//* An interface is a class that contains a list of fields and methods headers

//* Dart nas no 'interface' keyword (no explicit interfaces)
//* Every class defines an interface automatically
//! Use 'implements' to make a class promise to fulfill another class’s contract.
//* Use 'extends' to inherit both contract and implementation.
//* Use abstract class' when you want to define only the contract (and force subclasses to implement).
//* Can implement multiple interfaces (classes, both abstract or not)

//! abstract class - used to declare an interface. - contains just

abstract class UserRepositoryInterface {
  late final List<int> usersList;
  void create();
  List<int> read();
  void update();
  void delete();
}

class UserRepository implements UserRepositoryInterface {
  @override
  late final List<int> usersList;

  UserRepository() {
    usersList = read();
  }

  @override
  void create() => print('Created');

  @override
  void update() => print('Updated');

  @override
  List<int> read() => [1, 2, 3, 4, 5];

  @override
  void delete() => print('Deleted');
}

// class Animal {
//   final String name;
//   Animal({required this.name});

//   void whatAmI() => print('I\'m an animal');
//   void chase(Animal a) {}
// }

// class Mouse extends Animal {
//   Mouse (): super(name: 'Jerry');
// }

// class Cat extends Animal {
//   Cat() : super(name: 'Tom');
//   @override
//   void chase(covariant Mouse m) {}
// }

// class Bird extends Animal {
//   Bird(String name) : super(name: name);
// }

// class Duck extends Bird {
//   Duck(String name) : super(name);

//   @override
//   void whatAmI() => print('I\'m a duck!');

//   void swim() {}
// }


void main(List<String> args) {
  UserRepository userRepository = UserRepository();
  userRepository.create();
  userRepository.read();
  userRepository.update();
  userRepository.delete();
}
