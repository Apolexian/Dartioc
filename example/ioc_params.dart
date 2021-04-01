import 'package:dartioc/dartioc.dart';

void main() {
  Container('user').register(User, () => User('Generic'));

  var user = Container('user').locate(User);
  print(user.name); // Generic

  Container('user').register(User, () => Bob('Bob'));

  user = Container('user').locate(User);
  print(user.name); // Bob

  Container('user').register(User, () => Alice('Alice'));

  user = Container('user').locate(User);
  print(user.name); // Alice

  // register a singleton
  Container('user').register(User, () => Alice('Alice'), singleton: true);
  Container('user').locate(User).printName(); // Alice

  // register a singleton
  Container('user').register(User, () => Bob('Bob'), singleton: true);
  Container('user').locate(User).printAge(); // 20
}

class User {
  String name;

  User(this.name);
}

class Bob extends User {
  Bob(String name) : super(name);

  void printAge() {
    print('20');
  }
}

class Alice extends User {
  Alice(String name) : super(name);

  void printName() {
    print(name);
  }
}
