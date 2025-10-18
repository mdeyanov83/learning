//! switch case statement
// Snippet available
// stripped down version of an if/else
//! switch case can compare only int, String or any other compile-time constant values
//! however most often switch is used with the enum type -- look next file

void main(List<String> args) {

  var expression = 'Sunny';

  //! switch case can compare only int, String or any other compile-time constant values
  switch (expression) {

    //! if(identical(condition, 'Sunny'))
    case 'Sunny':
      print('It\'s sunny!');
      break;
    case 'Cloudy':
      print('It\'s cloudy!');
      break;
    case 'Drizzly':
      print('It\'s drizzly!');
      break;
    case 'Rainy':
      print('It\'s rainy!');
      break;

    default:
      print('Unknown weather!');
  }

  // above is equivalent to the below if/else statement

  if (expression == 'Sunny') {
    print('It\'s sunny!');
  } else if (expression == 'Cloudy') {
    print('It\'s cloudy!');
  } else if (expression == 'Drizzly') {
    print('It\'s drizzly!');
  } else if (expression == 'Rainy') {
    print('It\'s rainy!');
  } else {
    print('Unknown weather!');
  }

}
