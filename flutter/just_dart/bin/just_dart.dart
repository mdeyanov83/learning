
int multipliedByTwo(int a) => a * 2;


Future<int> heavyFutureThatMultipliesByTwo(int a) {
  return Future.delayed(const Duration(seconds: 3), () => a);
}


void test() {


}

void main(List<String> arguments) {

  test();

}
