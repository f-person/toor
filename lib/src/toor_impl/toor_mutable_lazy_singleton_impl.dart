part of '../toor.dart';

class _ToorMutableLazySingletonImpl<T> extends ToorMutableLocator<T>
    with _ToorLazySingletonMixin<T> {
  _ToorMutableLazySingletonImpl(
    FactoryFunc<T>? lazySingletonCreator,
    this.onDispose,
  ) {
    _initialLazySingletonCreator = this.lazySingletonCreator =
        lazySingletonCreator ?? _uninitializedFactoryFuncCreator();
  }

  static FactoryFunc<T> _uninitializedFactoryFuncCreator<T>() {
    return () => throw ToorUninitializedMutableSingletonException<T>();
  }

  late final FactoryFunc<T> _initialLazySingletonCreator;

  @override
  late FactoryFunc<T> lazySingletonCreator;
  @override
  late DisposeFunc<T>? onDispose;

  @override
  void put(T value) {
    lazySingletonCreator = () => value;
    super.reset();
  }

  @override
  void reset() {
    lazySingletonCreator = _initialLazySingletonCreator;
    super.reset();
  }
}

class ToorUninitializedMutableSingletonException<T> implements Exception {
  @override
  String toString() {
    final singleton = _formatTypeAsVariableName<T>();
    final singletonWithDefaultValue = '${singleton}WithDefaultValue';

    return '''
It seems that you accessed the value of the singleton of type $T before initialization.
To avoid this exception, you can add a default value:
```
final $singleton = Toor.instance.registerMutableLazySingleton();
final $singletonWithDefaultValue = Toor.instance.registerMutableLazySingleton(
  create: () => $T(),
);

void main() {
  print($singletonWithDefaultValue()); /// Prints just fine
  print($singleton()); /// Throws an error
}
```
''';
  }

  static String _formatTypeAsVariableName<T>() {
    final typeString = T.toString();
    return '${typeString[0]}${typeString.substring(1)}Singleton';
  }
}
