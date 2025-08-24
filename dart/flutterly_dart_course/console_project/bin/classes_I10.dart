//! Classes

//! Setters // Timestamp 4:58:00
// example, setting 

class Car {
  late int age;
  set manufacturedYear(int value) => age = 2025 - value; // current year 2025
}

void main() {

  var car = Car();
  car.manufacturedYear = 2006;

  // car.age;
  print('car.age --> ${car.age}');

}
