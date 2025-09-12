
int multipliedByTwo(int a) => a * 2;


Future<int> heavyFutureThatMultipliesByTwo(int a) {
  return Future.delayed(Duration(seconds: 2), () => a * 2);
}


void test() async {
  final result = await heavyFutureThatMultipliesByTwo(10);
  print(result);

}

void main(List<String> arguments) {

  test();

}
