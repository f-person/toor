import 'dart:async';

import 'package:meta/meta.dart';

part 'toor_impl/toor_factory_impl.dart';
part 'toor_impl/toor_impl.dart';
part 'toor_impl/toor_lazy_singleton_impl.dart';
part 'toor_impl/toor_mutable_lazy_singleton_impl.dart';
part 'toor_locator/resettable_locator.dart';
part 'toor_locator/toor_locator.dart';
part 'toor_locator/toor_locator_async.dart';
part 'toor_top_level_locators.dart';
part 'toor_test/toor_test.dart';

/// A simple service locator manager that lets you register compile-time safe
/// factories and lazy singletons.
abstract class Toor {
  /// Provides access to the default Singleton instance of [Toor].
  static Toor get instance => _instance;

  /// The default instance of [Toor].
  /// Accessed through the [instance] getter.
  ///
  /// As it is lazily initialized (thanks to `late` keyword),
  /// it will only be created once [instance] is accessed.
  static late final Toor _instance = _ToorImpl();

  /// Creates a new instance of [_ToorImpl].
  ///
  /// This lets you group factories and singletons by registering them
  /// on a specific [Toor] instance. This lets you to separate locators
  /// and reset a selected group of locators when needed.
  factory Toor.newInstance() {
    return _ToorImpl();
  }

  /// {@template ToorRegisterLazySingleton}
  /// Registers a singleton which will be created once called.
  /// {@endtemplate}
  ///
  /// {@template ToorSingletonOnDispose}
  /// [onDispose] is an optional callback that's called when
  /// resetting the locator (via [reset]).
  /// {@endtemplate}
  ToorLocator<T> registerLazySingleton<T>(
    FactoryFunc<T> lazySingletonCreator, {
    DisposeFunc<T>? onDispose,
  });

  /// {@template ToorRegisterMutableLazySingleton}
  /// Registers a singleton which has a mutable value.
  /// In order to mutate the value of the singleton,
  /// call [put].
  ///
  /// {@macro ToorSingletonOnDispose}
  /// {@endtemplate}
  ToorMutableLocator<T> registerMutableLazySingleton<T>({
    FactoryFunc<T>? create,
    DisposeFunc<T>? onDispose,
  });

  /// {@template ToorRegisterFactory}
  /// Registers a factory (i. e. a new instance of [T] will be created via
  /// [factoryFunc] on every call of [ToorFactory.create()]).
  /// {@endtemplate}
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc);

  /// {@template ToorRegisterFactoryWithOneParam}
  /// {@macro ToorRegisterFactory}
  ///
  /// Factories, created with [registerFactoryWithParam] allow you to
  /// pass a single parameter to the factory you're creating.
  /// {@endtemplate}
  ToorLocatorWithOneParameter<T, P1> registerFactoryWithParam<T, P1>(
    FactoryFuncWithOneParameter<T, P1> factoryFunc,
  );

  /// {@template ToorRegisterFactoryWithTwoParams}
  /// {@macro ToorRegisterFactory}
  ///
  /// Factories, created with [registerFactoryWithTwoParams] allow you to
  /// pass two parameters to the factory you're creating.
  /// {@endtemplate}
  ToorLocatorWithTwoParameters<T, P1, P2>
      registerFactoryWithTwoParams<T, P1, P2>(
    FactoryFuncWithTwoParameters<T, P1, P2> factoryFunc,
  );

  /// {@template ToorRegisterFactoryAsync}
  /// Registers an asynchronous factory via [factoryFunc].
  ///
  /// This might be useful when injecting a dependency to [T], that can only
  /// be obtained asynchronously (e.g. `SharedPreferences.getInstance()`).
  /// {@endtemplate}
  ToorLocatorAsync<T> registerFactoryAsync<T>(FactoryFuncAsync<T> factoryFunc);

  /// {@template ToorRegisterFactoryAsyncWithOneParam}
  /// {@macro ToorRegisterFactoryAsync}
  ///
  /// Factories, created with [registerFactoryAsyncWithParam] allow
  /// you pass a single parameter to the factory you're creating.
  /// {@endtemplate}
  ToorLocatorAsyncWithOneParameter<T, P1> registerFactoryAsyncWithParam<T, P1>(
    FactoryFuncAsyncWithOneParameter<T, P1> factoryFunc,
  );

  /// {@template ToorRegisterFactoryAsyncWithTwoParams}
  /// {@macro ToorRegisterFactoryAsync}
  ///
  /// Factories, created with [registerFactoryAsyncWithTwoParams] allow you to
  /// pass two parameters to the factory you're creating.
  /// {@endtemplate}
  ToorLocatorAsyncWithTwoParameters<T, P1, P2>
      registerFactoryAsyncWithTwoParams<T, P1, P2>(
    FactoryFuncAsyncWithTwoParameters<T, P1, P2> factoryFunc,
  );

  /// {@template ToorReset}
  /// Resets all registered lazy singletons.
  ///
  /// After executing this function, the next call to [ToorLocator.get] on
  /// a lazy singleton will result in creating a new instance via
  /// the `lazySingletonCreator` callback, provided to [registerLazySingleton].
  /// {@endtemplate}
  void reset();
}
