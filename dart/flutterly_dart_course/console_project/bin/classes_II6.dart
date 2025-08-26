/*
! Classes
! Extension Methods - timestamp 5:28:35
* Extension methods - a way to add functionality to existing libraries and classes
* You can create extension methods on any class
*/

// class IntegerExtension extends int{ //! Error - int class cannot be extended
//   int get luckyNumber => 12;
// }
//? int.luckyNumber - this is what we want to have

extension IntegerExtension on int{
  int get luckyInteger => 12;
  int add15() => this + 15;
}

void main() {
  int intNumber = 5;

  // 5.luckyNumber; // int object - 5
  print('5.luckyInteger --> ${5.luckyInteger}');

  // 10.add15();
  print('10.add15() --> ${10.add15()}');
}
