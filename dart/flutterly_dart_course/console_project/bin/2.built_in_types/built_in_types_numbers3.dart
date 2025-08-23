void main(List<String> arguments) {

  String s = '5';
  int integer = int.parse(s);
  double d = double.parse(s);
  num n = num.parse(s);
  print("$integer $d $n");

  String s1 = integer.toString();
  String s2 = d.toString();
  String s3 = n.toString();
  print("$s1 $s2 $s3");

  int clampedIntOutput = integer.clamp(0, 1);
  double clampedDoubleOutput = d.clamp(6, 6.5);
  num clampedNumOutput = n.clamp(0.0, 5.5);
  print("$clampedIntOutput $clampedDoubleOutput $clampedNumOutput");

  d = 14.6;
  //! ceil, floor, round are methods only on double objects
  int ceiledValue = d.ceil();
  int flooredValue = d.floor();
  int roundValue = d.round();
  print('''Ceil of $d: $ceiledValue \nFloor of $d: $flooredValue \nRound of $d: $roundValue''');

}
