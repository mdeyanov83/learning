


class Cat{
  final String name;
  Cat(this.name);
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
}

void main(List<String> arguments) {

  test();

}
