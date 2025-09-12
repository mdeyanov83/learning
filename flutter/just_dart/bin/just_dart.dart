

class PairOfStrings {
  final String value1;
  final String value2;
  PairOfStrings(this.value1, this.value2);

}

class PairOfIntegers {
  final int value1;
  final int value2;
  PairOfIntegers(this.value1, this.value2);

}

class Pair<A, B> {
  final A value1;
  final B value2;
  Pair(this.value1, this.value2);

}

void test() async {
  final names = Pair('foo', 2);
  print(names.value1);
  print(names.value2);
}

void main(List<String> arguments) {

  test();

}
