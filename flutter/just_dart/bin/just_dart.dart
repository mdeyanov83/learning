

Stream<String> getName() {
  return Stream.value('Foo');
}

void test() async {
  await for (final value in getName());
  print(value);

}

void main(List<String> arguments) {

  test();

}
