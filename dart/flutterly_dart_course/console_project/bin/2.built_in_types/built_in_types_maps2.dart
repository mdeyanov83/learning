void main(List<String> args) {

  var map1 = {};
  var map2 = {1: 2};
  map1.addEntries([MapEntry(1, 2)]); //! using the .addEntries() method is useful for bulk adding map entries
  print(map1);

  var map3 = {...map2};
  print(map3);

  //! Maps also support if and for statements within the map, just like Lists and Sets
}
