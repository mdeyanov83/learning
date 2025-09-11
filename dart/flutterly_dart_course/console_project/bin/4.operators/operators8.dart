/*

! Conditional expressions    /   Conditional Invocation Operator
! syntax:
! condition ? expr1 : expr2;
! If condition is true, then expr1, else expr2

! ?? - null-coalescing operator - it provides a default value if something is null

! ?. - conditional invocation operator
null-aware operator that lets you safely call a method or access a property only if the object is not null.
If the object is null, the entire expression returns null instead of throwing an error.
object?.method();
object?.property;

*/
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

//! Demonstrate .? and ??
int listLength(List<String>? names) {

  // If names is null, names?.length is null, therefore length gets assigned 0, otherwise it get assigned the actual value returned by .length
  final length = names?.length ?? 0;
  return length;
}
