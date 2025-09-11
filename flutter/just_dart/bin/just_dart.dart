

class Person {
  final String name;

  Person(this.name);

  void printName() {
    print('I will now print the name of this person');
    print(name);
  }

}


void test() {

  final foo = Person('Foo Bar');

  foo.printName();
}


void main(List<String> arguments) {

  test();

}
