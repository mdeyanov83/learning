


abstract  class LivingThing {
  void breathe() {
    print('Living thing is breathing');
  }
  void move() {
    print('I am moving');
  }
}


class Cat extends LivingThing {


}





void test() {
  final fluffers = Cat();

  fluffers.breathe();
  fluffers.move();
}

void main(List<String> arguments) {

  test();

}
