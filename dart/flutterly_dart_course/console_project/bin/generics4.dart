/*
! Generics - timestamp 5:50:15


*/


//! In oder for the method to work with other types than int (String for ex.) we need
//! to either create another method accepting String
class Utils{
  static int? getItemInt(List<int> list, int index) =>
    list.asMap().containsKey(index) ? list[index] : null;


  static String? getItemString(List<String> list, int index) =>
    list.asMap().containsKey(index) ? list[index] : null;


}
//! or make a generic method
// class Utils<T>
//   static T? getItem<T>(List<T> list, int index) =>
//     list.asMap().containsKey(index) ? list[index] : null;

// }


void main(List<String> args) {
  var listInt = [1, 2, 3, 4];
  var listSring = ['a', 'b'];

  print(Utils.getItemInt(listInt, 1));
  print(Utils.getItemString(listInt, 1));


}
