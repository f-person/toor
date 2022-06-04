part of 'toor.dart';

class _ToorImpl extends Toor {
  @override
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
    return _ToorFactoryImpl(factoryFunc);
  }

  @override
  ToorLocator<T> registerLazySingleton<T>(
    LazySingletonFunc<T> lazySingletonFunc,
  ) {
    return _ToorLazySingletonImpl(lazySingletonFunc);
  }
}

class _ToorFactoryImpl<T> extends ToorLocator<T> {
  const _ToorFactoryImpl(this.factoryFunc);

  final FactoryFunc<T> factoryFunc;

  @override
  T get() => factoryFunc();
}

class _ToorLazySingletonImpl<T> extends ToorLocator<T> {
  _ToorLazySingletonImpl(this.lazySingletonFunc);

  final LazySingletonFunc lazySingletonFunc;

  T? _instance;

  @override
  T get() {
    return _instance ??= lazySingletonFunc();
  }

  @override
  void dispose() {
    _instance = null;
  }
}
