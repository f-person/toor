part of '../toor.dart';

class _ToorLazySingletonImpl<T> extends ToorLocator<T> {
  _ToorLazySingletonImpl(this.lazySingletonCreator);

  late FactoryFunc<T> lazySingletonCreator;

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
