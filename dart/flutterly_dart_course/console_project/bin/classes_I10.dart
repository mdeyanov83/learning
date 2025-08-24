//! Classes

//! Setters // Timestamp 4:58:00


class Car {
  late int age;
  set manufacturedYear(int Value) => age = 2025 - value;
}


void main() {

  var car = Car();
  car.manufacturedYear = 2006;

  // car.age;
  print('car.age --> ${car.age}');

}
