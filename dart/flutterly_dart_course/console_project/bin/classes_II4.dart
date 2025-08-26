//! Classes 2

//! Mixins (continued) // timestamp 5:20:00
//* How class hierarchy work?
//* Mixins are applied left -> right. Rightmost mixin wins if there are conflicting methods


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
