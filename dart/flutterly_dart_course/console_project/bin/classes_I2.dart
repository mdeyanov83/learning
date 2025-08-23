//! Classes

//! Inheritance

// Every class extends the Object class by default
// therefore, even an empty class can access the Object class methods

//! Default methods from an extended class can be overridden
// @override
// super.methodName() - the super keyword, calls the base class method (from with our class is extended)
// if we want to use the default implementation in our own override method


class A { // same a ->  Class A extends Object {}

  @override
  String toString() {
    // super.toString(); // not needed if we dont want to use the default implementation
    return 'This is A!';
  }

}

void main(List<String> args) {

  // Object o;

  var a = A();
  var hashCode = a.hashCode;
  print('hashCode --> $hashCode');

  var runtimeType = a.runtimeType;
  print('runtimeType --> $runtimeType');

  var str = a.toString();
  print('str --> $str');


}


