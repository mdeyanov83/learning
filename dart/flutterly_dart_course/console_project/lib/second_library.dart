// library second_library; // not necessary

import 'package:console_project/first_library.dart';

void anotherFunction() {
  var a = A();

  a.publicField;
  a.publicMethod();

  //! not accessible
  // a._privateField;
  // a._privateMethod();

  publicTopLevelFunction();

}
