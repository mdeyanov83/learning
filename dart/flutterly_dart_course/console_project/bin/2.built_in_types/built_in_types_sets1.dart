void main(List<String> args) {

  //! Sets, similar to Lists
  //! Sets - Unordered collection of unique objects

  var list = [];
  list.add(1);
  list.add(3);
  list.add(2);
  list.add(3);
  print(list);

  // var set = <int>{}; same as below
  Set<int> set_ = {};
  set_.add(1);
  set_.add(3);
  set_.add(2);
  set_.add(3);
  print(set_);

  //! How to create a set
  var set1 = Set(); // Creates an empty set of type dynamic
  print(set1);

  Set<String> set2_ = {'Hey', 'WCKD'};
  print(set2_);

  var set3  = {1, 2, 3}; // using var infers the type, but must be assigned a non-empty set
  print(set3);

  var set4 = <int>{}; // var to infer type, but inferring type before an empty set literal {}
  print(set4);

  var set5 = {}; // This sets the variable to a Map instead of a Set

  //! Common methods almost identical to Lists
  var set = {1, 2, 3}
    ..add(15)
    ..addAll({7, 8, 5});
  set.add(4);
  set.addAll({5, 6, 7});
  var set2 = {10, 11, 12, ...set, if (true) set};
  print(set2);

}

