/*
! Libraries & Private fields - timestamp 5:57:00

? What these libraries are?
? How they really work?
? Where they actually live?

* How private fields work in conjunction with libraries

* Every .dart file is a library by default, even if not declared
* Libraries containing the implementations from inside a package must be in the lib/ folder
* Only libs from inside the lib/ folder can be accessed from an outside package

! Private fields - are library private fields, not class private fields
* Private fields and methods can be only access from within the entire library itself.
* Once it is imported into another package - they cannot be accessed

! Every feature/special functionality -> should be placed into a separate library

? Can one library be formed out of more than one file?
* Yes - a library can be formed by one or more files.
* In case - multiple files - then each file is no longer a separate library, but rather represent the same library
! main library - use 'part' directive
part 'first_library_extension_1.dart'
! second library - use 'part of' directive
part of 'first_library.dart'
* second becomes part of the main


? Can one library contain multiple libraries?



*/

// Importing own package by using the package: directive
// first_library.dart is located inside the lib/ folder
import 'package:console_project/first_library.dart';

void main(List<String> args) {
  var a = A();

  //! Private fields and methods cannot be accessed from outside of the imported library
  // a._privateField;
  // a._privateMethod();


}


