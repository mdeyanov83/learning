library first_library; // library names are not necessary

part 'first_library_extension_1.dart';


const int _privateTopLevel = 15;
const int publicTopLevel = 12;

void _privateTopLevelFunction() {}
void publicTopLevelFunction() {}

class A {
  final int _privateField = 5;
  void _privateMethod() {}

  final int publicField = 10;
  void publicMethod() {}
}

void randomFunc() {

  var a = A();

  //* note that all private fields and methods can be accessed inside the same library
  a._privateField;
  a._privateMethod();
}
