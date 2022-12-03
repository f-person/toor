part of '../toor.dart';

class _ToorLazySingletonImpl<T> extends ToorLocator<T>
    with _ToorLazySingletonMixin<T> {
  _ToorLazySingletonImpl(this.lazySingletonCreator, this.onDispose);

  @override
  late FactoryFunc<T> lazySingletonCreator;
  @override
  late DisposeFunc<T>? onDispose;
}

mixin _ToorLazySingletonMixin<T> on ToorLocator<T> {
  abstract FactoryFunc<T> lazySingletonCreator;
  abstract DisposeFunc<T>? onDispose;

  late _ToorLazySingletonHolder<T> _instanceHolder = _createInstanceHolder();

  @override
  T get() {
    return _instanceHolder.instance;
  }

  @override
  void reset() {
    if (_instanceHolder.isInitialized) {
      onDispose?.call(_instanceHolder.instance);
    }

    _instanceHolder = _createInstanceHolder();
  }

  _ToorLazySingletonHolder<T> _createInstanceHolder() {
    return _ToorLazySingletonHolder<T>(lazySingletonCreator);
  }
}

class _ToorLazySingletonHolder<T> {
  _ToorLazySingletonHolder(this.lazySingletonCreator);

  final FactoryFunc<T> lazySingletonCreator;

  late final T instance = _createLazySingleton();
  bool get isInitialized => _isInitialized;

  bool _isInitialized = false;

  T _createLazySingleton() {
    _isInitialized = true;

    return lazySingletonCreator();
  }
}
