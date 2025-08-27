/*
! Generics - timestamp 5:47:00

! Data Structures - Stack implementation
Stack is a LIFO data structure - Last In - First Out


*/




class Stack<T> {
  // _stack - private
  final List<T> _stack = [];

  // getters - returning the peak(last element) and the length of the stack
  T get peak => _stack.last;
  int get length => _stack.length;

  // getter
  bool canPop => _stack.isNotEmpty;
  // method to check if we can pop an element or not
  bool canPop() => _stack.isNotEmpty;

  // pop method
  T pop() {
    final T last = _stack.last;
    _stack.removeLast();
    return last;
  }

  // push method
  void push(T value) => _stack.add(value);
}



void main(List<String> args) {

  var stackInt = Stack<int>();
  var stackString = Stack<String>();

  stackInt.push(2);
  stackInt.push(3);
  stackInt.push(4);
  print(stackInt.pop()); // should print 4 and pop the 4 out of the stack
  print(stackInt.peak); // should print 3
}
