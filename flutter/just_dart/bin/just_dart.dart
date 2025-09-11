

class Person {
  final String name;

  Person(this.name);

  void printName() {
    print(name);
  }

}


void test() {

  final foo = Person('Foo Bar');


  print(foo.name);
}


void main(List<String> arguments) {

  test();

}
