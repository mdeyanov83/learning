/*
! Classes
! Mixins (continued 2) - specify which classes can a mixin be mixed with
! 'on' keyword
*/


class Performer {
  void perform() => print('Performs!');
}

//* Guitarist can be only mixed in with Performer
mixin Guitarist on Performer {
  void playGuitar() => print('Playing the guitar');
  void test() => perform();
}

mixin Drummer {
  void playDrums() => print('Playing the drums');
  void perform() => playDrums();
}

// class Musician with Guitarist {} //! Error
class Musician extends Performer with Drummer, Guitarist{} //* Works fine

void main() {
  Musician musician = Musician();

  musician.test(); // Calls the Drums method according to hierarchy (right to left)
}
