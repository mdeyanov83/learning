
//! Callable Classes

void main(List<String> args) {
  var a = A();
  a(); //! calling the call method using the default ()
  a.testMethod();

  A()(); //! The call method could even be called like that without instantiating a variable object

}


class A{
  void call() => print("I'm a function! :)"); //! must implement the call method inside the class
  void testMethod() => print("Test method");
}
