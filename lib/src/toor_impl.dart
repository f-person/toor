part of 'toor.dart';

class _ToorImpl extends Toor {
  @override
  ToorFactory<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
    return _ToorFactoryImpl(factoryFunc);
  }
}

class _ToorFactoryImpl<T> implements ToorFactory<T> {
  const _ToorFactoryImpl(this.factoryFunc);

  final FactoryFunc<T> factoryFunc;

  @override
  T create() => factoryFunc();
}
