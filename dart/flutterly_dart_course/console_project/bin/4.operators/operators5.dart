//! Assignment Operators
//! all operators = += -+ *= /= ~/= %= <<= >>= &= |= ^= ??=

//! = standard assignment operator
//! += -= *= /= addition, subtraction, multiplication, division assignment operators
//! ~/= integer division
  // int x = 10;
  // x ~/= 3;   // x = 10 ~/ 3 → 3

//! %= modulo assignment operator
  // int x = 10;
  // x %= 3;    // x = 10 % 3 → 1

//! Bitwise assignment operators
//! <<= >>= left and right shift assignment operators (shifts bits to the left or right)
  // int x = 2; // 0010
  // x <<= 2;   // 1000 → 8

  // int x = 2; // 0010
  // x <<= 2;   // 1000 → 8

//! &= bitwise AND and assign
  // int x = 6; // 110
  // x &= 3;    // 110 & 011 → 010 → 2
//! |= bitwise OR and assign
  // int x = 2; // 010
  // x |= 1;    // 010 | 001 → 011 → 3
//! ^= bitwise XOR and assign
  // int x = 3; // 011
  // x ^= 1;    // 011 ^ 001 → 010 → 2

//! ??= null aware assignment operator
//! shorthand syntax for the assignment operator for a variable
//! only if the variable hasn't been assigned a value yet
  // int? x;
  // x ??= 10;  // x was null, so now x = 10
  // print(x);  // 10
  // x ??= 20;  // x is not null, so assignment is skipped
  // print(x);  // still 10

void main(List<String> args) {
  int? a;
  print(a);
  a ??= 5;
  print(a); // 5, because a was null prior to ??= assignment
  a ??= 10;
  print(a); // still 5

  int b = 1;
  ++b;
  b++;
  b += 3;
  print(b); // 6
}
