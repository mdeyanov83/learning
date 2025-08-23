//! Control Flow Statements

//! if/else
//! for loop
//! while / do while loop
//! break/continue
//! switch case
//! assert
//! try, throw, catch, finally


//! if/else
// Snippets available for if and if/else (ife)
// The expression within an if must evaluate to bool
// if/else can be written as a conditional expression
  // condition ? expr1 : expr2
  // the false expression - expr2 is obligatory, however can be replaces with null

// void main(List<String> args) {
//   int a = 5;
//   int b = 6;
//   if (a.isEven) {
//     print('$a is even!');
//   } else {
//     print('$a is not even!');
//   }
//   //! Using the ternary operator ?:
//   b.isEven ? print('$b is even!') : null;
// }


//! for loop
// Snippets available for for loop and for in loop
// void main(List<String> args) {
//   var list = [1, 2, 3, 4, 5];

//   for (var i = 0; i < list.length; i+=2) {
//     print(list[i]);
//   }

//   for (var item in list) {
//     print(item);
//   }

//   list.forEach((element) {
//     print(element);
//   });
//   list.forEach((element) => print(element));
//   list.forEach(print);
// }

//! while / do while loops
// Snippets available for do and do while
// Must be careful about infinite loops if the condition never evaluates to false

// void main(List<String> args) {

//   var list = [1, 2, 3, 4, 5];
//   list.forEach(print);

//   // evaluates the condition before running the code block
//   int i = 0;
//   while (i != 5) {
//     i++;
//     print(i);
//   }

//   // Will always run at least once, as the evaluation comes after the code block
//   i = 0;
//   do {
//     i++;
//     print(i);
//   } while (i != 5);
// }

//! break / continue
// Used in all loops
// break - breaks out of the loop execution
// continue - skips the current loop iteration and moves to the next one

void main(List<String> args) {

  var list = [1, 2, 3, 4, 5];

  //breaks out of the loop once 4 is reached
  for (var i = 0; i < list.length; i++) {
    if(list[i] == 4) break;
    print(list[i]);
  }

  // skips over the iteration when 4, but executes over the rest
  for (var i = 0; i < list.length; i++) {
    if(list[i] == 4) continue;
    print(list[i]);
  }

  // Using list collection functions like 'where' and 'forEach'
  list.where((element) => element != 2).forEach(print);



}
