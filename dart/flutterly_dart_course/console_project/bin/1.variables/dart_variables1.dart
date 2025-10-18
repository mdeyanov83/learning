//! Variables
//! Lazy initialization using 'late' but still assigning a value

// Can be useful when initialization is expensive, or it is not certain if it will be used at all

late int value = 100; // will not be initialized upon declaration, but when it is first used (lazy initialization)
  // not much benefit here, because the variable is instantiated anyway.


class WeatherStation {
  late int temperature = readTemperature();
  int readTemperature() => 25;
}


void main(List<String> args) {

  print(value.isEven); // will be initialized here, when accessed for the first time


  var weatherStation = WeatherStation(); // the temperature field will not be initialized here
  print(weatherStation.temperature); // but rather here, when accessed for the first time


}
