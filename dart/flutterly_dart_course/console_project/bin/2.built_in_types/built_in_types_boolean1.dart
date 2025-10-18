void main(List<String> arguments) {

  bool b = true;
  //! if (b == true)
  if (b) {
    print('The statement is true');
  }

  //! if (3 > 2 == true)
  if (3 > 2) {
    print('3 is greater than 2');
  }

  //! If statement accepts only expression that evaluate to boolean
  int a = 5;
  String name = 'WKCD';
  String? passenger;

  if (a != 0) {
    print('a is not zero');
  }
  if (name.isNotEmpty) {
    print('name is not empty');
  }
  if (passenger != null) {
    print('passenger is not null');
  } else {
    print('passenger is null');
  }

}
