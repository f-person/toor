part 'toor_impl.dart';

typedef FactoryFunc<T> = T Function();

abstract class Toor {
  static late final Toor _instance = _ToorImpl();

  /// access to the Singleton instance of Toor
  static Toor get instance => _instance;

  ToorFactory<T> registerFactory<T>(FactoryFunc<T> factoryFunc);
}

abstract class ToorFactory<T> {
  T create();
}
