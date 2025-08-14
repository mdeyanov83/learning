void main() {

  // Person p1 = Person("John", "Male", 41);
  // p1.showData();
  // p1.showDataVerbose();

  // Without initialization (remove the constructor and create a method for adding data)

  Person p1 = Person();
  p1.showData();

  // Add data

  // p1.name = "John";
  // p1.sex = "Male";
  // p1.age = 41;
  p1.addData("John", "Male", 41);

  p1.showData();

}

class Person {
  String? name, sex;
  int? age;

  // // Constructors
  // Person(this.name, this.sex, this.age);

  // Method
  void addData(String name, sex, int age) {
    this.name = name;
    this.sex = sex;
    this.age = age;
  }

  // Methods
  void showData() {
    print("Name = $name");
    print("Sex = $sex");
    print("Age = $age");
  }

  void showDataVerbose() {
    print("The person's name is $name, they are $sex and $age old");
  }
}
