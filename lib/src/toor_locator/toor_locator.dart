part of '../toor.dart';

/// Signature for factory and lazy singleton creator functions.
typedef FactoryFunc<T> = T Function();

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
