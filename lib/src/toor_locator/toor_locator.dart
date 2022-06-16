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

/// The base for all types of locators.
abstract class ToorLocatorBase implements ResettableLocator {
  const ToorLocatorBase();

  @override
  void reset() {
    // Overriden by default since not every locator does something on reset.
  }
}

/// {@template ToorLocatorBase}
/// Used for interacting with factories or singletons registered with [Toor].
/// {@endtemplate}
abstract class ToorLocator<T> extends ToorLocatorBase {
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
abstract class ToorLocatorWithOneParameter<T, P1> extends ToorLocatorBase {
  const ToorLocatorWithOneParameter();

  /// {@macro ToorLocatorGet}
  T get(P1 param1);

  /// {@macro ToorLocatorCall}
  T call(P1 param1) => get(param1);
}

/// {@macro ToorLocatorBase}
///
/// This type of locators allow you to create factories with two parameters.
abstract class ToorLocatorWithTwoParameters<T, P1, P2> extends ToorLocatorBase {
  const ToorLocatorWithTwoParameters();

  /// {@macro ToorLocatorGet}
  T get(P1 param1, P2 param2);

  /// {@macro ToorLocatorCall}
  T call(P1 param1, P2 param2) => get(param1, param2);
}
