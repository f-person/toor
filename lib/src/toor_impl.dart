part of 'toor.dart';

class _ToorImpl extends Toor {
  @override
  ToorFactory<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
    return _ToorFactoryImpl(factoryFunc);
  }

  @override
  ToorLazySingleton<T> registerLazySingleton<T>(
    LazySingletonFunc<T> lazySingletonFunc,
  ) {
    return _ToorLazySingletonImpl(lazySingletonFunc);
  }
}

class _ToorFactoryImpl<T> extends ToorFactory<T> {
  const _ToorFactoryImpl(this.factoryFunc);

  final FactoryFunc<T> factoryFunc;

  @override
  T create() => factoryFunc();
}

class _ToorLazySingletonImpl<T> extends ToorLazySingleton<T> {
  _ToorLazySingletonImpl(this.lazySingletonFunc);

  final LazySingletonFunc lazySingletonFunc;

  T? _instance;

  @override
  T get() {
    return _instance ??= lazySingletonFunc();
  }

  @override
  void reset() {
    _instance = null;
  }
}
