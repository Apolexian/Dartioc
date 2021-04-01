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

  void register<T>(dynamic dependency, T Function() builder,
      {bool singleton = false}) {
    if (singleton == true) {
      singletons[dependency] = builder();
      return;
    }
    bindings[dependency] = builder;
  }

  T locate<T>(dynamic dependency) {
    if (singletons[dependency] != null) {
      return singletons[dependency];
    }
    if (bindings[dependency] != null) {
      return bindings[dependency]();
    }
    return null;
  }

  void unregister(dynamic dependency) {
    bindings.remove(dependency);
  }

  void unregisterSingleton(dynamic dependency) {
    singletons.remove(dependency);
  }
}
