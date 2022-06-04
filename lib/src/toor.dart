part 'toor_impl.dart';

typedef FactoryFunc<T> = T Function();

typedef LazySingletonFunc<T> = T Function();

abstract class Toor {
  static late final Toor _instance = _ToorImpl();

  /// Access to the Singleton instance of Toor.
  static Toor get instance => _instance;

  /// Registers a factory (i. e. a new instance of [T] will be created via
  /// [factoryFunc] on every call of [ToorFactory.create()]).
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc);

  /// Registers a singleton which will be created once called.
  ToorLocator<T> registerLazySingleton<T>(
    LazySingletonFunc<T> lazySingletonFunc,
  );
}

abstract class ToorLocator<T> {
  const ToorLocator();

  T get();

  T call() => get();

  void dispose() {}
}
