/// An [instance] of container will hold the registered dependencies for that
/// instance. If the container is already registered we just retrieve it from
/// the [_cache], otherwise we can create a new one using a non existing key
/// and cache it.
class Container {
  static final Map<String, Container> _cache = <String, Container>{};
  static Container instance;
  final String containerKey;
  final Map bindings = {};
  final Map singletons = {};

  Container._internal(this.containerKey);

  factory Container(String key) {
    if (_cache.containsKey(key)) {
      return _cache[key];
    } else {
      final container = Container._internal(key);
      _cache[key] = container;
      return container;
    }
  }

  /// Register a [dependency] and assign a [builder] function to the registered
  /// dependency. The [builder] should be a constructor or some other method that
  /// builds the object you want to be linked to the [dependency]. If singleton
  /// is specified then the object will be built and put into the container, thus
  /// the same instance of it will be retrieved later. Otherwise, the specified
  /// [builder] will be used every time when retrieving.
  void register<T>(dynamic dependency, T Function() builder,
      {bool singleton = false}) {
    if (singleton == true) {
      singletons[dependency] = builder();
      return;
    }
    bindings[dependency] = builder;
  }

  /// Locate the builder for the specified [dependency], depends if the instance
  /// has been registered as a singleton or not. If the instance was registered as
  /// a singleton then it will retrieve the instance of the singleton, otherwise
  /// a new object will be constructed using the builder previously registered and
  /// returned. If the [dependency] can not be found in the container then the
  /// method will return null.
  T locate<T>(dynamic dependency) {
    if (singletons[dependency] != null) {
      return singletons[dependency];
    }
    if (bindings[dependency] != null) {
      return bindings[dependency]();
    }
    return null;
  }

  /// Unregister the given *non singleton* [dependency].
  void unregister(dynamic dependency) {
    bindings.remove(dependency);
  }

  /// Unregister the given *singleton* [dependency].
  void unregisterSingleton(dynamic dependency) {
    singletons.remove(dependency);
  }
}
