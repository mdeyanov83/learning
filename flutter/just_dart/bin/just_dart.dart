


class Cat{
  final String name;
  Cat(this.name);
}

class Person {
  final String firstName;
  final String lastName;
  Person(this.firstName, this.lastName);
}

extension FullName on Person {
  String get fullName => '$firstName $lastName';
}

extension Run on Cat {
  void run() {
    print('Cat $name is running');
  }
}


void test() {
  final meow = Cat('Fluffers');
  print(meow.name);
  meow.run();

  final foo = Person('Foo', 'Bar');
  print(foo.fullName);
}

void main(List<String> arguments) {

  test();

}
