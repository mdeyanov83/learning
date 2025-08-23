void main(List<String> arguments) {

  //! Collection if and for - building content inside of a list using conditionals and loops

  bool salesActive = true;

  var salesMenu = [
    'Offers1',
    'Offers2',
  ];
  List<String> menu = [
    'Home',
    'Store',
    'About',
    'Search',
    if (salesActive) 'sales offer',
    if (salesActive)
      for (var item in salesMenu) item,
  ];

  print(menu);

  //! The collection if and for are evaluated only once, at list creation. It's not reactive.
  salesActive = false;
  print(menu); // will print the same
}
