//! Classes 2

//! Mixins (continued) // timestamp 5:20:00
//? How class hierarchy work?
//* Mixins are applied left -> right. Rightmost mixin wins if there are conflicting methods
//? How hierarchy is built?
//* class A with M1, M2 {}
// is equivalent to
//* class A extends Object with M1 {}
//* class _A_M1 extends A with M2 {}
// so the class chain looks like:
// Object -> A+M1 -> A+M1+M2   // M2 overrides methods from M1





class Performer {
  void perform() => print('Performs!');
}

mixin Guitarist {
  void playGuitar() => print('Playing the guitar');
  void perform() => playGuitar();
}

mixin Drummer {
  void playDrums() => print('Playing the drums');
  void perform() => playDrums();
}

class Musician extends Performer with Drummer, Guitarist{}

//current 5:21:25

void main() {
  Musician musician = Musician();
  musician.playGuitar();
  musician.playDrums();
  musician.perform();
}
