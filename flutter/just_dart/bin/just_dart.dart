
Iterable<int> getOneTwoThree() sync* {
  for (int i = 0; i < 10; i++) {
    yield i;
  }

}


void test() async {
  for (final value in getOneTwoThree()) {
    if (value == 5) break;
    print(value);
  }
}

void main(List<String> arguments) {

  test();

}
