import "dart:io";

void main() {

  // User Input Type Conversion
  print("Enter a number: ");

  // Get user Input
  var nummy = stdin.readLineSync();

  // var nummy2 = int.parse(nummy ?? '0') + 10;
  var nummy2 = int.parse((nummy?.isNotEmpty ?? false) ? nummy! : '0') + 10;

  print("$nummy + 10 = $nummy2");

}
