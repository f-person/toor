part of 'toor.dart';

/// The default implementation of [Toor].
class _ToorImpl implements Toor {
  /// {@macro ToorRegisterFactory}
  @override
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
    return _ToorFactoryImpl(factoryFunc);
  }

  /// {@macro ToorRegisterLazySingleton}
  @override
  ToorLocator<T> registerLazySingleton<T>(
    FactoryFunc<T> lazySingletonCreator,
  ) {
    return _ToorLazySingletonImpl(lazySingletonCreator);
  }
}
