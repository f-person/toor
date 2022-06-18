part of '../toor.dart';

/// The interface that all resettable locators implement.
abstract class ResettableLocator {
  /// If this locator is a lazy singleton, the current instance will be deleted,
  /// and a new one will be called on the next [get] call.
  ///
  /// Nothing will happen if this [ToorLocator] is a factory.
  void reset();
}
