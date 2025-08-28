part of 'first_library.dart'; // relative path

void anotherFunction() {
  var a = A();

  a.publicField;
  a.publicMethod();

  //! not accessible
  // a._privateField;
  // a._privateMethod();

  //* top level variables and methods can be shared within libraries
  publicTopLevel;
  publicTopLevelFunction();

  //! top level private are not
  // _privateTopLevel;
  // _privateTopLevelFunction();

  //* math accessible here, but imported in the primary file
  var s = math.sin(90);

}
