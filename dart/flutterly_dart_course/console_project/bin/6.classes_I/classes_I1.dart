//! Classes

// the default class constructor is not constant


class A {

}

void main(List<String> args) {

  var a1 = A();
  var a2 = A();

  var isIdentical = identical(a1, a2);
  print('isIdentical ->> $isIdentical'); // false
  print(a1 == a2); // false

}
