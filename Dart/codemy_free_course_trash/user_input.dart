import "dart:io";

void main() {
  // User Input
  print("Enter Your Name: ");

  // allow the user to enter their name
  String? name = stdin.readLineSync();

  print("Hello $name");
}
