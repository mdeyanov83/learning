//! Anonymous functions (lambdas, closures)
//! Don't require a name
//! Only need the parameters list and a code block denoting the body of the function

// void main(List<String> args) {

//   var list = ["hello", "everyone", "wckd"].map(applyUpperCaseChanges).toList();
//   print(list);
// }

// String applyUpperCaseChanges(String s) {
//   return s.toUpperCase();
// }

//! Using a closure (anonymous function)
// void main(List<String> args) {
//   var list = ["hello", "everyone", "wckd"].map((String s) {
//     return s.toUpperCase();
//   }).toList();
//   print(list);
// }

//! closure + shorthand arrow syntax
void main(List<String> args) {
  var list = ["hello", "everyone", "wckd"].map((String s) => s.toUpperCase()).toList();
  print(list);

}
