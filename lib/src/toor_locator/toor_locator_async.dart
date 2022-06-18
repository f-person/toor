part of '../toor.dart';

/// Signature for asynchronous factories.
typedef FactoryFuncAsync<T> = Future<T> Function();

/// Signature for one-parameter async factory creator functions.
typedef FactoryFuncAsyncWithOneParameter<T, P1> = Future<T> Function(P1 param1);

/// Signature for two-parameter async factory creator functions.
typedef FactoryFuncAsyncWithTwoParameters<T, P1, P2> = Future<T> Function(
  P1 param1,
  P2 param2,
);

/// The class for using async factories registered with [Toor].
abstract class ToorLocatorAsync<T> extends ToorLocatorBase {
  const ToorLocatorAsync();

  /// {@macro ToorLocatorGet}
  Future<T> get();

  /// {@macro ToorLocatorCall}
  Future<T> call() => get();
}

/// {@macro ToorLocatorBase}
///
/// This type of locators allow you to create
/// async factories with one parameter.
abstract class ToorLocatorAsyncWithOneParameter<T, P1> extends ToorLocatorBase {
  const ToorLocatorAsyncWithOneParameter();

  /// {@macro ToorLocatorGet}
  Future<T> get(P1 param1);

  /// {@macro ToorLocatorCall}
  Future<T> call(P1 param1) => get(param1);
}

/// {@macro ToorLocatorBase}
///
/// This type of locators allow you to create
/// async factories with two parameters.
abstract class ToorLocatorAsyncWithTwoParameters<T, P1, P2>
    extends ToorLocatorBase {
  const ToorLocatorAsyncWithTwoParameters();

  /// {@macro ToorLocatorGet}
  Future<T> get(P1 param1, P2 param2);

  /// {@macro ToorLocatorCall}
  Future<T> call(P1 param1, P2 param2) => get(param1, param2);
}
