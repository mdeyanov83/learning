void main(List<String> args) {

  //! Runes - a collection containing all DECIMAL UNICODE CODE POINTS of a String
  //! CODE POINT - integer value uniquely identifying a given UNICODE CHARACTER from inside a String

  //! Strings - are a sequence of UTF-16 CODE UNITS
  //! CODE UNIT - the unit of storage of an ENCODED CODE POINT

  Runes runes = Runes("Hello");
  print(runes); // Prints the decimal value of the code unit

  var runesList16 = runes.map((e) => e.toRadixString(16)
    .padLeft(4, '0')).toList();
  print(runesList16); // Prints the unicodes in UTF-16

  //! string interpolation using \u{unicode} within the string literal
  String hello = '\u{0048}\u{0065}\u{006c}\u{006c}\u{006f}';
  print(hello);

  String roseEmoji  = '\u{1F339}';
  print(roseEmoji);
}
