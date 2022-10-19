part of 'toor.dart';

final _instance = Toor.instance;

/// {@macro ToorRegisterLazySingleton}
ToorLocator<T> registerLazySingleton<T>(
  FactoryFunc<T> lazySingletonCreator, {
  DisposeFunc<T>? onDispose,
}) {
  return _instance.registerLazySingleton(
    lazySingletonCreator,
    onDispose: onDispose,
  );
}

/// {@macro ToorRegisterFactory}
ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc) {
  return _instance.registerFactory(factoryFunc);
}

/// {@macro ToorRegisterFactory}
/// {@macro ToorRegisterFactoryWithOneParam}
ToorLocatorWithOneParameter<T, P1> registerFactoryWithParam<T, P1>(
  FactoryFuncWithOneParameter<T, P1> factoryFunc,
) {
  return _instance.registerFactoryWithParam(factoryFunc);
}

/// {@macro ToorRegisterFactory}
/// {@macro ToorRegisterFactoryWithTwoParams}
ToorLocatorWithTwoParameters<T, P1, P2> registerFactoryWithTwoParams<T, P1, P2>(
  FactoryFuncWithTwoParameters<T, P1, P2> factoryFunc,
) {
  return _instance.registerFactoryWithTwoParams(factoryFunc);
}

/// {@macro ToorRegisterFactoryAsync}
ToorLocatorAsync<T> registerFactoryAsync<T>(FactoryFuncAsync<T> factoryFunc) {
  return _instance.registerFactoryAsync(factoryFunc);
}

/// {@macro ToorRegisterFactoryAsync}
/// {@macro ToorRegisterFactoryAsyncWithOneParam}
ToorLocatorAsyncWithOneParameter<T, P1> registerFactoryAsyncWithParam<T, P1>(
  FactoryFuncAsyncWithOneParameter<T, P1> factoryFunc,
) {
  return _instance.registerFactoryAsyncWithParam(factoryFunc);
}

/// {@macro ToorRegisterFactoryAsync}
/// {@macro ToorRegisterFactoryAsyncWithTwoParams}
ToorLocatorAsyncWithTwoParameters<T, P1, P2>
    registerFactoryAsyncWithTwoParams<T, P1, P2>(
  FactoryFuncAsyncWithTwoParameters<T, P1, P2> factoryFunc,
) {
  return _instance.registerFactoryAsyncWithTwoParams(factoryFunc);
}
