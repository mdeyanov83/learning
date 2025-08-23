void main(List<String> args) {

  String s1 = 'Hello, WKCD!';
  String s2 = "It's sunny outside";
  String s3 = 'It\'s sunny outside';

  //! String interpolation
  //! single identifier - $, expression ${}
  double temperature = 25.4;
  String celsius = 'celsius';

  String s4 = 'It is $temperature degrees ${celsius.toUpperCase() }';
  print(s4);

  //! String concatenation
  String a = 'Hello';
  String b = 'WKCD';
  String simpleConcatenation = 'Hello' 'WKCD';
  String plusConcatenation = a + b;
  print(simpleConcatenation);
  print(plusConcatenation);

  String intro = "Hello, everyone! \nI'm WKCD, welcome back!"; //! \n delimiter -> new line
  print(intro);
  //! Multi-line string using triple quote '''content''' or """content"""
  String intro2 = '''Hello, everyone!
I'm WKCD, welcome back!''';
  print(intro2);

  //! Raw string - prefix with r'content' - ignores escape characters
  String rawString = r'I want this \n to be part of the string!';
  print(rawString);

  //! Unicode - \u{unicode} - print the unicode character
  String unicodeExample = "Here's the rose emoji: \u{1F339}";
  print(unicodeExample);

  //! String literals are constant values, as long as
  //! any interpolated expression within them evaluates to a constant value
  String constant1 = 'Yes $temperature';
  String constant2 = 'Yes $temperature';
  print(constant1.hashCode);
  print(constant2.hashCode);

}
