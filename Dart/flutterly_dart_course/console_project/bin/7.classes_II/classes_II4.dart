/*
! Classes 2
! Mixins (continued) // timestamp 5:20:00

? How class hierarchy work?
* Mixins are applied left -> right. Rightmost mixin wins if there are conflicting methods
? How hierarchy is built?
* class A with M1, M2 {}
is equivalent to
* class A extends Object with M1 {}
* class _A_M1 extends A with M2 {}
so the class chain looks like:
* Object -> A+M1 -> A+M1+M2   // M2 overrides methods from M1
? Adding a superclass?
class Base {
  void hello() => print("Hello from Base");
}
class A extends Base with M1, M2 {}
* The resolution order is: Object -> Base -> A+M1 -> A+M1+M2
* Method lookup checks in the following order:
* M2 -> M1 -> Base -> Object

In the following example musician.perform(); will call the Guitarist method
Performer is mixed in with Drummer, Guitarist
Performer -> Performer + Drummer -> Performer + Drummer + Guitarist -> Musician

* If we do not extend another class, by default we extend Object
Class Musician with Drummer, Guitarist {}
Object -> Object + Drummer -> Object + Drummer + Guitarist - Musician
*/

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

void main() {
  Musician musician = Musician();
  musician.playGuitar();
  musician.playDrums();
  musician.perform(); // Calls the Guitarist method
}
