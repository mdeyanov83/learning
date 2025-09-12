

Stream<String> getName() {
  return Stream.periodic(const Duration(seconds: 1), );
}

void test() async {
  await for (final value in getName()) {
    print(value);
  }
  print('Stream finished working');
}

void main(List<String> arguments) {

  test();

}
