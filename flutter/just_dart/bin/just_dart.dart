


class Cat{
  final String name;
  Cat(this.name);
}


extension Run on Cat {
  
}


void test() {
  final meow = Cat('Fluffers');
  print(meow.name);
}

void main(List<String> arguments) {

  test();

}
