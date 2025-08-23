//! Conditional expressions
//! syntax:
//! condition ? expr1 : expr2;
//! If condition is true, then expr1, else expr2

//! ?? - null-coalescing operator - it provides a default value if something is null

void main(List<String> args) {

}

Car rewardCar1(Car? dreamCar) {
  if (dreamCar == null) {
    return Car('Random');
  }
  return dreamCar;
}

//! condition? expr1 : expr2
Car rewardCar2(Car? dreamCar) => dreamCar != null ? dreamCar : Car('Random');

//! expr1 != null ? expr1 : expr2 => expr1 ?? expr2
// using null-coalescing operator, providing default value if something is null
Car rewardCar3(Car? dreamCar) => dreamCar ?? Car('Random');


class Car {
  final String name;
  Car(this.name);
}
