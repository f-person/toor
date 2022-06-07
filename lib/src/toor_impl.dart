part of 'toor.dart';

/// The default implementation of [Toor].
class _ToorImpl implements Toor {
  /// Keeps track of references to lazy singletons.
  ///
  /// [WeakReference] is used because the user might assign another value
  /// to the variable, holding a [ToorLocator] (i. e. make it null).
  /// In this case it will be garbage-collected and automatically removed
  /// from [_locatorReferences] on next [reset] call.
  final List<WeakReference<ToorLocator>> _locatorReferences = [];

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
    final lazySingleton = _ToorLazySingletonImpl(lazySingletonCreator);
    _locatorReferences.add(WeakReference(lazySingleton));

    return lazySingleton;
  }

  /// {@macro ToorReset}
  @override
  void reset() {
    for (int index = _locatorReferences.length - 1; index >= 0; index--) {
      final lazySingleton = _locatorReferences[index].target;
      if (lazySingleton == null) {
        _locatorReferences.removeAt(index);
      } else {
        lazySingleton.reset();
      }
    }
  }
}
