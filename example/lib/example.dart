import 'package:dart_inversion_of_control/dartioc.dart';

void main() {
  Container('user').register(User, () => User());

  var user = Container('user').locate(User);
  print(user.name); // Generic

  Container('user').register(User, () => Bob());

  user = Container('user').locate(User);
  print(user.name); // Bob

  Container('user').register(User, () => Alice());

  user = Container('user').locate(User);
  print(user.name); // Alice

  // register a singleton
  Container('user').register(User, () => Alice(), singleton: true);
  Container('user').locate(User).printName(); // Alice

  // register a singleton
  Container('user').register(User, () => Bob(), singleton: true);
  Container('user').locate(User).printAge(); // Alice
}

class User {
  String name = 'Generic';
}

class Bob extends User {
  @override
  String name = 'Bob';

  void printAge() {
    print('20');
  }
}

class Alice extends User {
  @override
  String name = 'Alice';

  void printName() {
    print(name);
  }
}
