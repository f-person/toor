part of 'toor.dart';

@visibleForTesting
extension ToorLocatorOverrider<T> on ToorLocator<T> {
  @visibleForTesting
  void override(FactoryFunc<T> factoryFunc) {
    final locator = this;

    if (locator is _ToorFactoryImpl<T>) {
      locator.factoryFunc = factoryFunc;
    } else if (locator is _ToorLazySingletonImpl<T>) {
      locator.lazySingletonCreator = factoryFunc;
      locator._instanceHolder = locator._createInstanceHolder();
    }
  }
}
