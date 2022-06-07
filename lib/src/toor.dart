import 'package:meta/meta.dart';

part 'toor_impl.dart';
part 'toor_factory_impl.dart';
part 'toor_lazy_singleton_impl.dart';
part 'toor_test.dart';

/// Signature for factory and lazy singleton creator functions.
typedef FactoryFunc<T> = T Function();

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
}

/// The class for using factories or singletons registered with [Toor].
abstract class ToorLocator<T> {
  const ToorLocator();

  /// Retrieves or creates the instance registered in this [ToorLocator].
  T get();

  /// Makes instances of `ToorLocator` callable by implementing
  /// the function interface.
  T call() => get();

  /// If this [ToorLocator] is a lazy singleton, the
  /// current instance will be deleted, and a new one will be called on the
  /// next [get] call.
  ///
  /// Nothing will happen if this [ToorLocator] is a factory.
  ///
  /// See also [_ToorLazySingletonImpl], [_ToorFactoryImpl].
  void reset();
}
