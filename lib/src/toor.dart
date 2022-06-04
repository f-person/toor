part 'toor_impl.dart';

typedef FactoryFunc<T> = T Function();

typedef LazySingletonFunc<T> = T Function();

abstract class Toor {
  static late final Toor _instance = _ToorImpl();

  /// Access to the Singleton instance of Toor.
  static Toor get instance => _instance;

  /// Registers a factory (i. e. a new instance of [T] will be created via
  /// [factoryFunc] on every call of [ToorFactory.create()]).
  ToorFactory<T> registerFactory<T>(FactoryFunc<T> factoryFunc);

  /// Registers a singleton which will be created once called.
  ToorLazySingleton<T> registerLazySingleton<T>(
    LazySingletonFunc<T> lazySingletonFunc,
  );
}

abstract class ToorFactory<T> {
  const ToorFactory();

  /// Creates a new instance of [T].
  T create();

  T call() => create();
}

abstract class ToorLazySingleton<T> {
  const ToorLazySingleton();

  /// Returns the created instance of [T]. If an instance is not created
  /// yet, a new one will be created.
  T get();

  T call() => get();

  /// Deletes the current instance of [T].
  void reset();
}
