void main(List<String> args) {

  //! Maps - objects containing key-value pairs
  //! Both keys and values can be any type of object
  //! Keys - must be unique

  //! How to create a map object and assign it to a map variable
  var map1 = {}; // inferred type is map, {} is the default literal for maps

  var map2 = {
    1: 1,
    2: 2,
    3: 3,
  };
  var map3 = Map();
  map3['wckd'] = 'yay';
  map3['value'] = '6';

  print(map3);
  print(map2[1]!.isOdd); // The map index operator [index] is nullable, therefore bang operator (! - null assertion) must be used

}
