part of '../toor.dart';

/// The default implementation of [Toor].
class _ToorImpl implements Toor {
  /// Keeps track of references to lazy singletons.
  ///
  /// [WeakReference] is used because the user might assign another value
  /// to the variable, holding a [ToorLocator] (i. e. make it null).
  /// In this case it will be garbage-collected and automatically removed
  /// from [_locatorReferences] on next [reset] call.
  final List<WeakReference<ToorLocatorBase>> _locatorReferences = [];

  /// {@macro ToorRegisterLazySingleton}
  @override
  ToorLocator<T> registerLazySingleton<T>(
    FactoryFunc<T> lazySingletonCreator, {
    DisposeFunc<T>? onDispose,
  }) {
    final lazySingleton = _ToorLazySingletonImpl(
      lazySingletonCreator,
      onDispose,
    );
    _locatorReferences.add(WeakReference(lazySingleton));

    return lazySingleton;
  }

  /// {@macro ToorRegisterFactory}
  @override
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
    return _ToorFactoryImpl(factoryFunc);
  }

  /// {@macro ToorRegisterFactoryWithOneParam}
  @override
  ToorLocatorWithOneParameter<T, P1> registerFactoryWithParam<T, P1>(
    FactoryFuncWithOneParameter<T, P1> factoryFunc,
  ) {
    return _ToorFactoryWithOneParameterImpl(factoryFunc);
  }

  /// {@macro ToorRegisterFactoryWithTwoParams}
  @override
  ToorLocatorWithTwoParameters<T, P1, P2>
      registerFactoryWithTwoParams<T, P1, P2>(
    FactoryFuncWithTwoParameters<T, P1, P2> factoryFunc,
  ) {
    return _ToorFactoryWithTwoParametersImpl(factoryFunc);
  }

  /// {@macro ToorRegisterFactoryAsync}
  @override
  ToorLocatorAsync<T> registerFactoryAsync<T>(FactoryFuncAsync<T> factoryFunc) {
    return _ToorFactoryAsyncImpl(factoryFunc);
  }

  /// {@macro ToorRegisterFactoryAsyncWithOneParam}
  @override
  ToorLocatorAsyncWithOneParameter<T, P1> registerFactoryAsyncWithParam<T, P1>(
    FactoryFuncAsyncWithOneParameter<T, P1> factoryFunc,
  ) {
    return _ToorFactoryAsyncWithOneParameterImpl(factoryFunc);
  }

  /// {@macro ToorRegisterFactoryAsyncWithTwoParams}
  @override
  ToorLocatorAsyncWithTwoParameters<T, P1, P2>
      registerFactoryAsyncWithTwoParams<T, P1, P2>(
    FactoryFuncAsyncWithTwoParameters<T, P1, P2> factoryFunc,
  ) {
    return _ToorFactoryAsyncWithTwoParametersImpl(factoryFunc);
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
