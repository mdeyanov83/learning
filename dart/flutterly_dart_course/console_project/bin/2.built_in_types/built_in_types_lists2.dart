void main(List<String> arguments) {

  //! How to create a list object and assign it to a value
  List<int> a = [];
  List<int> b = [1, 2, 3];
  List<int> c = List.filled(4, 7);
  List<int> d = List.empty(growable: true);
  List<int> d2 = List.from([1, 2, 3], growable: true);
  List<int> e = List.generate(3, (index) => index * 2);

  d.add(19);
  print(a);
  print(b);
  print(c);
  print(d);
  print(d2);
  print(e);

  //! ... spread operator - spreads (explodes) all elements of a collection
  List<int> f = [...b];
  print(f);

}
