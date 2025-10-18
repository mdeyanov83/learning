void main(List<String> arguments) {

  int a = 15;
  int b = 2;
  var c = a / b; //! Division operator outputs a double value
  var d = a ~/ b; //! Truncation operator outputs an integer
  print(c);
  print(d);

  var e1 = 0 / 0; //! NaN
  var e = a / 0; //! Infinity
  // var f = a ~/ 0; //! Error
  print(e1);
  print(e);
}
