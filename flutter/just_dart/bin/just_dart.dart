


class Cat extends Object{
  final String name;
  Cat(this.name);
  @override
  bool operator ==(covariant Cat other) => other.name == name;

  @override
  int get hashCode => name.hashCode;
}





void test() {
  final cat1 = Cat('Foo');
  final cat2 = Cat('Foo');

  if (cat1 == cat2) {
    print('They are equal');

  } else {
    print('They are not equal');
  }

  print(cat1.hashCode);
  print(cat2.hashCode);
  print(identical(cat1, cat2));



}

void main(List<String> arguments) {

  test();

}
