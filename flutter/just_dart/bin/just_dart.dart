

class Person {
  void run() {
    print('Running');
  }
  void breathe() {
    print('Breathing');
  }
}


void test() {

  final person = Person();

  person.run();
  person.breathe();

}


void main(List<String> arguments) {

  test();

}
