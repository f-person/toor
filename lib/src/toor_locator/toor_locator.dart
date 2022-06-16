part of '../toor.dart';

/// Signature for factory and lazy singleton creator functions.
typedef FactoryFunc<T> = T Function();

/// Signature for one-parameter factory and lazy singleton creator functions.
typedef FactoryFuncWithOneParameter<T, P1> = T Function(P1 param1);

/// Signature for two-parameter factory and lazy singleton creator functions.
typedef FactoryFuncWithTwoParameters<T, P1, P2> = T Function(
  P1 param1,
  P2 param2,
);

/// {@template ToorLocatorBase}
/// Used for interacting with factories or singletons registered with [Toor].
/// {@endtemplate}
abstract class ToorLocator<T> implements ResettableLocator {
  const ToorLocator();

  /// {@template ToorLocatorGet}
  /// Retrieves or creates the instance registered in this [ToorLocator].
  /// {@endtemplate}
  T get();

  /// {@template ToorLocatorCall}
  /// Makes instances of `ToorLocator` callable by implementing
  /// the function interface.
  /// {@endtemplate}
  T call() => get();
}

/// {@macro ToorLocatorBase}
///
/// This type of locators allow you to create factories with one parameter.
abstract class ToorLocatorWithOneParameter<T, P1> implements ResettableLocator {
  const ToorLocatorWithOneParameter();

  /// {@macro ToorLocatorGet}
  T get(P1 param1);

  /// {@macro ToorLocatorCall}
  T call(P1 param1) => get(param1);
}

/// {@macro ToorLocatorBase}
///
/// This type of locators allow you to create factories with two parameters.
abstract class ToorLocatorWithTwoParameters<T, P1, P2>
    implements ResettableLocator {
  const ToorLocatorWithTwoParameters();

  /// {@macro ToorLocatorGet}
  T get(P1 param1, P2 param2);

  /// {@macro ToorLocatorCall}
  T call(P1 param1, P2 param2) => get(param1, param2);
}
