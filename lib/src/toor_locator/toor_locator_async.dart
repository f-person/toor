part of '../toor.dart';

/// Signature for asynchronous factories.
typedef FactoryFuncAsync<T> = Future<T> Function();

/// The class for using async factories registered with [Toor].
abstract class ToorLocatorAsync<T> {
  const ToorLocatorAsync();

  /// Creates the instance registered in this [ToorLocator].
  Future<T> get();

  /// Makes instances of `ToorLocatorAsync` callable by implementing
  /// the function interface.
  Future<T> call() => get();
}
