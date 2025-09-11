


class Cat {
  final String name;
  Cat(this.name);
}





void test() {
  final cat1 = Cat('Foo');
  final cat2 = Cat('Foo');

  if (cat1 == cat2) {
    print('They are equal');

  } else {
    print('They are not equal');
  }


}

void main(List<String> arguments) {

  test();

}
