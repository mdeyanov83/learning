void main(List<String> args) {

  //! List literal, unlike numbers, strings and booleans, list literals are not constants by default
  List<int> list1 = [1, 2, 3];
  List<int> list2 = [1, 2, 3];

  print(list1.hashCode); // different hash
  print(list2.hashCode); // different hash

  //! We can make them constant
  List<int> list3 = const [1, 2, 3];
  List<int> list4 = const [1, 2, 3];

  print(list3.hashCode); // same hash
  print(list4.hashCode); // same hash

}
