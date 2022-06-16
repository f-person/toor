import 'package:meta/meta.dart';

part 'toor_locator/toor_locator.dart';
part 'toor_locator/toor_locator_async.dart';
part 'toor_test/toor_test.dart';
part 'toor_impl/toor_impl.dart';
part 'toor_impl/toor_factory_impl.dart';
part 'toor_impl/toor_lazy_singleton_impl.dart';

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

  /// {@template ToorRegisterFactory}
  /// Registers a factory (i. e. a new instance of [T] will be created via
  /// [factoryFunc] on every call of [ToorFactory.create()]).
  /// {@endtemplate}
  ToorLocator<T> registerFactory<T>(FactoryFunc<T> factoryFunc);

  /// {@template ToorRegisterLazySingleton}
  /// Registers a singleton which will be created once called.
  /// {@endtemplate}
  ToorLocator<T> registerLazySingleton<T>(
    FactoryFunc<T> lazySingletonCreator,
  );

  /// {@template ToorRegisterFactoryAsync}
  /// Asynchronously registers a factory via [factoryFunc].
  ///
  /// This might be useful when injecting a dependency to [T], that can only
  /// be obtained asynchronously (e.g. `SharedPreferences.getInstance()`).
  /// {@endtemplate}
  ToorLocatorAsync<T> registerFactoryAsync<T>(FactoryFuncAsync<T> factoryFunc);

  /// {@template ToorReset}
  /// Resets all registered lazy singletons.
  ///
  /// After executing this function, the next call to [ToorLocator.get] on
  /// a lazy singleton will result in creating a new instance via
  /// the `lazySingletonCreator` callback, provided to [registerLazySingleton].
  /// {@endtemplate}
  void reset();
}
