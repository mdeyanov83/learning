//! Variables
//! declaration: var vs dynamic

void main(List<String> arguments) {
  //! var initialization - infers type from initial value
  var vi = 5; // same as int vi = 5;
  var vs = 'Example'; // same as String vs = "Example";
  var vl = [1, 2, 3]; // same as List<int> vl = [1, 2, 3];

  // vi = 5.0; // Error, cannot change type of a var initialized variable

  print("var runtimeTypes:");
  print(vi.runtimeType);
  print(vs.runtimeType);
  print(vl.runtimeType);

  //! dynamic initialization
  dynamic di = 5;
  dynamic ds = 'Example';
  dynamic dl = [1, 2, 3];

  print("\ndynamic runtimeTypes:");
  print(di.runtimeType);
  print(ds.runtimeType);
  print(dl.runtimeType);

  di = 5.0; // can change type of variable when assigned a different type value
  print(di.runtimeType); // It is now double, instead of int


}

