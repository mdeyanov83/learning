  //! Functions are objects
  //! Functions can be assigned to variables
  //! Functions can be passed as arguments to other functions
  //! Functions can be returned from other functions

void main(List<String> args) {
  var functionObject = first;
  // second(functionObject, 5);
  second((int a) => a, 5); //! (int a) => a    -> anonymous function (also called lambda or closure)
}

// int first(int a) {
//   return a;
// }
int first(int a) => a.isOdd ? 1 : 0; //! shorthand arrow syntax, when the function returns only a single expression

void second(int Function(int) f, int a) {
  print(f.call(a));
  print(f(a));
  // return null; //! for void functions, the statement return null; is implicitly appended at the end
}



