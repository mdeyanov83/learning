void main() {
  // Functions

  myFunc(String name1, {name2 = "friends"}) {
    // return "Hello, $name1 ${name2 != null ? 'and $name2' : 'no second parameter'}";
    return "Hello $name1 and $name2";
  }

  var thing = myFunc("John", name2: "Bill");
  print(thing);


}
