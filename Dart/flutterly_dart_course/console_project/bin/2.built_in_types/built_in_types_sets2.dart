void main(List<String> args) {

  //! Just like Lists to create a compile time constant set, use cons
  var setExample = const {1, 2, 3};
  var setExmaple2 = const {1, 2, 3};
  print(setExample.hashCode);
  print(setExmaple2.hashCode);


  //! Other useful set methods

  var set1 = {1, 2, 3};
  var set2 = {2, 3, 4};

  var intersect = set1.intersection(set2);
  var union = set1.union(set2);
  var difference = set1.difference(set2);

  print(intersect);
  print(union);
  print(difference);
  



}
