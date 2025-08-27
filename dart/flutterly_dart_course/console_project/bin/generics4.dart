/*
! Generics - timestamp 5:50:15


*/


class Utils<T>{
  // static int? getItem(List<int> list, int index) =>
  //   list.asMap().containsKey(index) ? list[index] : null;

  //! In oder for the method to work with other types than int (String for ex.) we need
  //! to either create another method accepting String
  // static String? getItem(List<String> list, int index) =>
  //   list.asMap().containsKey(index) ? list[index] : null;

  //! or make a generic method
  static T ? getItem(List<T> list, int index) =>
    list.asMap().containsKey(index) ? list[index] : null;

}


void main(List<String> args) {
  // var list = [1, 2, 3, 4];
  var list = ['a', 'b'];

  print(Utils.getItem(list, 1));


}
