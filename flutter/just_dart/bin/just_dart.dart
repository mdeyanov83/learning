


class Cat {
  final String name;

  Cat(this.name);

  factory Cat.fluffBall() {
    return Cat('FluffBall');
  }

}





void test() {

  final fluffBall = Cat.fluffBall();
  print(fluffBall.name);
}

void main(List<String> arguments) {

  test();

}
