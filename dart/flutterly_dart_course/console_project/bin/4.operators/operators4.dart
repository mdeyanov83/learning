//! TYPE TEST Operators

//! as - Typecast (also used with library prefixes)
//! is - True if the object is of the specified type
//! is! - True if the object is not of the specified type

//! as - used to cast a type as another type (also used with library prefixes - an alias for imported library)
// import 'dart:math' as math;
// math.method();

//! typecast functionality
void main(List<String> args) {
  var list = [1, 2.0, 'test', null];

  var i = list[0] as int; //! typecast must be used only when you are sure that the value is of the specified type
  var d = list[1] as double;
  var s = list[2] as String;
  // var n = list[3] as bool; //! results in a typecast exception
  var n = list[3] as Null;

  //! is and is! (is not) operators
  list.forEach((element) {
    if (element is int) {
      print('$element is of type int');

      //! Dart automatically converts element to int inside the if block if the statement is true
      //! so we can use the proper type methods inside the if block
      print(element.isEven);
      
    } else if (element is double) {
      print('$element is of type double');
    } else if (element is String) {
      print('$element is of type String');
    } else if (element is Null) {
      print('$element is of type Null');
    }
  });


}
