# Dartioc

A simple library to facilitate inversion of control in dart. Supports registering multiple
container instances that hold bindings to dependencies. Bindings can be declared as singletons.

You can find the package at: https://pub.dev/packages/dart_inversion_of_control

## Installing

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  dart_inversion_of_control: ^1.0.0
```

You can install packages from the command line:

```shell
dart pub get
```

## Usage

A simple usage example:

```dart
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
  Container('user').locate(User).printAge(); // 20
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
```

