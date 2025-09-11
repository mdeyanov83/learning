
enum AnimalType { cat, dog, bunny }


void test(AnimalType animalType) {

  switch(animalType) {
    case AnimalType.bunny:
      print("bunny");
      break;
    case AnimalType.cat:
      print("Cat");
    case AnimalType.dog:
      print("Dog");

  }


  print("Function is finised");

}


void main(List<String> arguments) {

  test( );

}
