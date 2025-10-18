//! Logical Operators
//! !expr - expression inverter
//! && - logical AND
//! || - logical OR
// They only work on expressions that evaluate to a boolean value true/false

void main(List<String> args) {
  var a = 5;
  if (a.isEven && a.isFinite || a.isNegative) {}

  var isFalse = !(true);
  print(isFalse);






}
