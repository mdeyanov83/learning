//! Equality & Relational Operators
//! == - Equality
//! != - Inequality
//! > - Greater than
//! < - Less than
//! >= - Greater than or equal to
//! <= - Less than or equal to

//! How equality is calculated
//! By default 2 objects are equal if they point to the same memory location (identity).

//! Dart has two distinct concepts:

//! Identity (same object in memory): checked with identical(a, b).
//! Equality (== operator): by default, this falls back to identity, but classes can override == to define value-based equality.

void main(List<String> args) {
  int a = 2;
  int b = 2;
  print(a == b); // true

  var list1 = [1, 2, 3];
  var list2 = [1, 2, 3];
  print(list1 == list2); // false

  var string1 = 'hello';
  var string2 = 'hello';
  print(
    string1 == string2,
  ); // true, overrides identity and uses value-based equality

  print('--identical() --');
  print(identical(a, b));
  print(identical(list1, list2));

  var a1 = const A(1, 2);
  var a2 = const A(1, 2);

  print('a1 == a2: ${a1 == a2}');
  print('identical(a1, a2): ${identical(a1, a2)}');
  print(a.hashCode);
  print(b.hashCode);

}


class A {
  final int a;
  final int b;

  const A(this.a, this.b);

  //! override == and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is A &&
      other.a == a &&
      other.b == b;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode;
}
