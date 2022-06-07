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

class _ToorFactoryImpl<T> extends ToorLocator<T> {
  const _ToorFactoryImpl(this.factoryFunc);

  final FactoryFunc<T> factoryFunc;

  @override
  T get() => factoryFunc();
}

class _ToorLazySingletonImpl<T> extends ToorLocator<T> {
  _ToorLazySingletonImpl(this.lazySingletonCreator);

  final FactoryFunc<T> lazySingletonCreator;

  late _ToorLazySingletonHolder<T> _instanceHolder = _createInstanceHolder();

  @override
  T get() {
    return _instanceHolder.instance;
  }

  @override
  void reset() {
    _instanceHolder = _createInstanceHolder();
  }

  _ToorLazySingletonHolder<T> _createInstanceHolder() {
    return _ToorLazySingletonHolder<T>(lazySingletonCreator);
  }
}

class _ToorLazySingletonHolder<T> {
  _ToorLazySingletonHolder(this.lazySingletonCreator);

  final FactoryFunc<T> lazySingletonCreator;

  late T instance = lazySingletonCreator();
}
