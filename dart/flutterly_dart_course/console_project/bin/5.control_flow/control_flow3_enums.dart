//! enum  !!!! Enumerations
//! Special class (type) used ot represent a fixed set of constant values
// UpperCamelCase is used for enums identifiers
// enum Color { red, green, blue }
//! Accessing enum values
  //! assigning a value: Color favorite = Color.green
  // variable type must be of type the enum class itself
  //! using in conditionals: if (favorite == Color.red) { do something }
  //! iterating over all values: for (var color in Color.values) { do something }
  // Color.values is a list of all enum values in the order the were defined
//! Dart enums can have constructors, fields and methods, just like any other class
// Fields -> store data for each value
// Constructors -> initialize each value
// Methods -> give behavior to values

enum Condition { sunny, cloudy, drizzly, rainy }

void main(List<String> args) {

  var condition = Condition.drizzly; // Infers type Condition, same as Condition condition = Condition.sunny

  //! Each case requires an exit statement - break, continue, throw or return
  // break - exits the switch statement
  // return - returns a value for the function
  // throw -
  // continue - passing to another case clause.
    // Useful when we want to do the something in response to 2 values
    // used with a label on another case

  switch (condition) {
    case Condition.sunny:
      print('It\'s sunny!');
      break; //? possible options: break, continue, throw, return
    case Condition.cloudy:
      print('It\'s cloudy!');
      break;
    //! if it's drizzly
    case Condition.drizzly:
      print('It\'s drizzly!');
      // break;
      continue rainy;
    //! it's also rainy
    rainy: // label
    case Condition.rainy:
      print('It\'s rainy!');
      break;

    default:
      print('Unknown weather!');
  }

  //! Empty cases
  switch (condition) {
    case Condition.sunny:
      print('It\'s sunny!');
      break; //? possible options: break, continue, throw, return
    case Condition.cloudy:
      print('It\'s cloudy!');
      break;
    case Condition.drizzly: //! Empty statement, in both drizzly and rainy it will print rainy
    case Condition.rainy:
      print('It\'s rainy!');
      break;

    default: //! In this case it is unnecessary, because with enums we cannot have values outside of the enum defined ones
      print('Unknown weather!');
  }

}
