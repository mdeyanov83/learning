//! BITwise Operators

//! & AND
//! | OR
//! ^ XOR
//! << Shift left
//! >> Shift right
//! ~ Complement (unary bitwise complement). Bitwise NOT - flips every bit in an integer
  // ~x is equvalent to -(x+1)
  // use cases - bit manipulation: flipping flags, masks or Low-level operations when working with binary data

void main(List<String> args) {
  var a = 6; // 0110 in binary
  var b = 5; // 0101

  print(a & b); // 0100 = 4
  print(a | b); // 0111 = 7
  print(a ^ b); // 0011 = 3
  print(a << 1); // 1100 = 12
  print(a >> 1); // 0011 = 3
  print(~a); // -7
}
