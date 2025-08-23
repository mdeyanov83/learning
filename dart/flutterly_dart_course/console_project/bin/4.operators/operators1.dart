//! Operators

//! For operators that require 2 operands, the leftmost is the one calling the operator function
//! basically a + b is a.+ b  (+ is a method of first operand a)


//! Arithmetic operators

//! + - addition
//! - - subtraction
//! * - multiplication
//! / - division (returns double)
//! ~/ - integer division
//! % - modulo (remainder)
//! -expr - reverse sign of expression

// void main(List<String> args) {
//   int a = 7;
//   int b = 2;

//   var c = a / b;
//   print(c);

//   var i = a ~/ b;
//   var r = a% b;

//   print('7/2 = $i r $r');
//   print('$i * 2 + $r = 7');
// }

//! Increment (++) and Decrement (--) operators
//! Dart support both prefix and postfix
void main(List<String> args) {
  var a = 5;

  //! Both work
  a++;
  print(a);
  ++a;
  print(a);

  //! However

  var b = 5;
  //! b1 = b, then b = b + 1;
  var b1 = b++;
  print(b1);

  //! b = b + 1, then b2 = b;
  var b2 = ++b;
  print(b2);
}
