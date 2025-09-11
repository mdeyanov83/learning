


class Cat {
  final String name;

  Cat(this.name);

  factory Cat.fluffBall() {
    this.name = 'FluffBall'
  }

}





void test() {

  final fluffBall = Cat('FluffBall');
  print(fluffBall.name);
}

void main(List<String> arguments) {

  test();

}
