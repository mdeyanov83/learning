//! Lexical Scope
//! The scope of the variable is determined by the curly brackets of the function it is defined in


//! demonstrate how each variable is accessible only within the scope of its function
//! and topLevel is accessible everywhere
// int topLevel = 5;
// void main(List<String> args) {
//   topLevel = 6;
//   void a() {
//     topLevel = 7;
//     var aVar = 0;
//     void b() {
//       topLevel = 7;
//       var bVar = 12;
//       void c() {
//         topLevel = 12;
//         bVar = 10;
//       }
//     }
//   }
// }


void main(List<String> args) {
  f();
  //! var a is gone after this
}

void f() {
  //! this will only exist within this scope
  var a = 5;
}



