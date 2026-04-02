void main(List<String> args) {
  var car = makeCar("BMW");
  print(car("M5"));
}

String Function(String) makeCar(String make) {
  var engine = "4.4 V8";
  return (model) => "$make $model $engine";
}
