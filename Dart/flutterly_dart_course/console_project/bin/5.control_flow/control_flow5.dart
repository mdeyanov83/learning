//! Exceptions
//! try, throw, catch, on, finally - statements
//! When exceptions are thrown, they must be caught, or the program execution will fail

//! exceptions are objects instantiated from the Exception class
// Exception class is similar to the Error class which acts the same
// quality code will always throw types or classes that implement either the Exception or the Error class
// exceptions - Represent conditions that a program can reasonably handle.
// errors - Represent serious problems that are usually due to programming mistakes.

//! throw - Used to raise(throw) an exception (an error condition)
// You can throw built-in exceptions (like FormatException) or your own custom ones
// throw Exception('Something went wrong!');

//! try - Used to wrap code that might throw an exception
// if no exception is thrown, code runs normally
// if an exception is thrown, Dart jumps to the matching 'catch' or 'on' block

//! catch - Used to catch exceptions thrown in a 'try' block and handle it
// two main forms of 'catch' blocks:
// catch(ExceptionType e) - catch any exception thrown in the 'try' block
// catch(ExceptionType e, StackTrace s) - catch any exception thrown in the 'try' block and print the stack trace

//! on - Used to catch a specific type of exception thrown in a 'try' block
// on ExceptionType { do something } - you dont get the exception itself
// on ExceptionType catch(e) { do something } - you also get the exception itself to log, inspect or use its details


//! finally - Execute the code block regardless of whether an exception is thrown or not
// Runs no matter what
// If not exception, runs after the try block
// if an exception is caught - runs after the catch block
// if an exception is uncaught - runs before the program crashes



import 'dart:math' as math;


void main(List<String> args) {
  int min = -1, max = 2;
  //! zero = -1 or 0 or 1
  int zero = min + math.Random().nextInt(max - min);
  print('Random zero: $zero');

  try {
    if (zero < 0) {
      throw NegativeValue(message: 'Negative value');
    } else if (zero > 0) {
      throw PositiveValue(message: 'Positive value');
    }
  } on NegativeValue {
      print('The value is negative');
  } catch (e) {
    if (e is PositiveValue) {
      print('The value is positive');
    }
  } finally {
    zero = 0;
  }
  if (zero == 0) {
    print('Zero at the end: $zero');
  }
}

class NegativeValue implements Exception {
  final String message;
  NegativeValue({required this.message});
}

class PositiveValue implements Exception {
  final String message;
  PositiveValue({required this.message});
}
