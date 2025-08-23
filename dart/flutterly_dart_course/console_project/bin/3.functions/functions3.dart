//! Function parameters
//! 4 types of parameters
//! Required Positional
//! Optional Positional
//! Required Named
//! Optional Named

void main(List<String> args) {
  requiredPositional(1, 2, 3);
  optionalPositional();
  requiredNamed(a: 12, b: 4);
  optionalNamed(b: 50);
  namedHybrid(a:18);
}


//! Required Positional parameters
//! Enumerated between the brackets, called positional because the order matters
void requiredPositional(int a, int b, int c) => print('$a $b $c');

//! Optional Positional parameters
//! Optional indicated by [ parameters ]
//! Either provide a default value or make them nullable by using ?
//! values must be passed in order, you cannot skip an optional parameter and provide value for the next
//! a workaround would be to provide the default value
void optionalPositional([int a = 5, int? b]) => print('$a $b');

//! Required Named parameters
//! Named indicated by { parameters }
//! required in front of type if required
void requiredNamed({required int a, required int b}) => print('$a $b');

//! Optional Named parameters
//! { parameters }
//! optional, by providing a default value and omitting "required" keyword
void optionalNamed({int a = 5, int b = 10}) => print("$a $b");

//! Named Hybrid
void namedHybrid({required int a, int b = 50}) => print("$a $b");

//! Hybrid
//! You can have required positional parameters, followed by either a [] or {} parameter block, but not both
void fullHybrid(int a, int b, int c, {required int d, int e = 50}) => print("$a $b $c $d $e");

