/*
! Libraries & Private fields - timestamp 5:57:00

? What these libraries are?
? How they really work?
? Where they actually live?

* How private fields work in conjunction with libraries

* Every .dart file is a library by default, even if not declared
* A package is a collection of libraries + configuration (pubslec.yaml)
* Libraries containing the implementations from inside a package must be in the lib/ folder
* Only libs from inside the lib/ folder can be accessed from an outside package

! Private fields - are library private fields, not class private fields
* Private fields and methods can be only access from within the entire library itself.
* Once it is imported into another package - they cannot be accessed

! Every feature/special functionality -> should be placed into a separate library

? Can one library be formed out of more than one file? YES!
* In case - multiple files - then each file is no longer a separate library, but rather represent the same library
! main library - use 'part' directive
part 'first_library_extension_1.dart'
! second library - use 'part of' directive
part of 'first_library.dart'
* second becomes part of the main

When implementing multiple files into the same library
- the only directive at the top must be "part of 'main_library.dart'" on the additional files
- any imports must be done in the primary library file, but they will be available in all the files
- all files from the library can access all _private and public fields and methods from the entire library
- ! if you want to access something from inside one of the extension files, the entire library must be imported

? Can one library contain multiple libraries? YES! - timestamp 6:11:40
! package name (project name): dart_libraries
* must be included in dependencies in the current project pubspec.yaml file-*
- folder: lib/top_library
- top_library.dart
- library1.dart
- library2.dart
- library3.dart

* Each file is a standalone library by itself
top_library - use export 'library1.dart' - then it will export it along with itself
* Then to import:
import 'package:dart_libraries/top_library/top_library.dart';  - imports the entire library, including exported ones in it
import 'package:dart_libraries/top_library/library1.dart'; - imports only library1.dart

? Both approaches - part/part of and export can be combined together for full control of how to structure our libraries

! Implementation libraries that we want to remain private (internal only to our package)?
* must be placed in the src/ folder
* they should be imported and used only by the package itself, not by other outside packages
* this rule is convention, not enforced!
* The fields inside the src/ folder are not part of the public API if the library is published

! General rules
* Rule #1 - Declare all your libraries containing feature implementations inside the lib/ folder
- When working on your main project code (bin/ folder) or test (test/ folder) always import libraries using
  import 'package:... ' directive.
  Never use relative paths ../ or ../../ to navigate outside of bin or test folders
  Always use package: to access something inside the lib folder
- When working on libraries inside the lib/ folder
  only import libraries from another package using package: directive
  Never import anything else from outside the lib/folder, since it will not be accessible when the current package
  gets imported somewhere else

* Rule #2 - Never reach in or out the lib folder by using relative imports, when you need to use the "package" directive
- Never use relative paths to navigate outside or inside of lib/ folder
  ../lib/   ../../
- Relative paths between libraries WITHIN the lib/ folder are permitted, just make sure you stay in the lib folder

! Recap
* Libraries containing specific implementations from your package should be placed in the lib/ folder
* A .dart file always represents a library unless:
  a) You want to have your library split into multiple files ('part' & 'part of' approach)
  b) You want to have multiple libraries inside a bigger library ('export' approach)
    However in this case each file is still a library by itself
* You should never reach in and out of the lib/ folder by using relative paths, always use the 'package:' directive

!!!!!!!! Other explanation
* Library - 1 Dart file (or a set of files grouped with 'part' and 'part of') --> basic unit of code organization
! Libraries should be named using snake_case: first_library_name.dart
* Package - A collection of libraries + configuration (pubspec.yaml) --> unit of distribution (shared via pub.dev  or locally)
* Import syntax:
  - Local library: import 'math_utils.dart';
  - External package: import 'package:http/http.dart';
    "package:..." - means 'look inside the lib/ folder of this package'
* Importing a local package - must first declare it as a dependency in the current project pubspec.yaml file
  dependencies:
    package_name:
      path: ../package_name
        or
      git: ... (for Git)
* Project - a package itself
* Library organization:
  - Exports (multiple independent libraries)
  - Parts (one library split across files)
  - src/ convention for internal code, only to be imported by local libraries
*/


// Importing local external package by using the package: directive
// first_library.dart is located inside the lib/ folder
import 'package:dart_libraries/first_library.dart';
import 'package:dart_libraries/top_library/top_library.dart';
import 'package:dart_libraries/top_library/library1.dart';

void main(List<String> args) {
  var a = A();

  //! Private fields and methods cannot be accessed from outside of the imported library
  // a._privateField;
  // a._privateMethod();


}


