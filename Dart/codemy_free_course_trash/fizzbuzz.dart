void main() {

  // FizzBuzz

  for (var num = 1; num <= 100; num++) {
    if (num % 15 == 0) {
      print("$num FizzBuzz!");
    } else if (num % 3 == 0) {
      print("$num Fizz");
    } else if (num % 5 == 0) {
      print("$num Buzz");
    } else {
      print(num);
    }
  }

  // int num = 1;
  // while (num <= 100) {
  //   if (num % 15 == 0) {
  //     print("$num FizzBuzz!");
  //   } else if (num % 3 == 0) {
  //     print("$num Fizz");
  //   } else if (num % 5 == 0) {
  //     print("$num Buzz");
  //   } else {
  //     print(num);
  //   }
  //   // increment the counter
  //   num++;
  // }

}
