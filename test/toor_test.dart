import 'package:test/test.dart';
import 'package:toor/toor.dart';

void main() {
  group('ToorFactory', () {
    test('returns a new instance when called', () {
      final objectFactory = Toor.instance.registerFactory(() => Object());
      final object1 = objectFactory();
      final object2 = objectFactory();

      expect(identical(object1, object2), isFalse);
    });

    test('creates different instances of ToorLocator', () {
      final toor = Toor.instance;

      final factory1 = toor.registerFactory(() => Object());
      final factory2 = toor.registerFactory(() => Object());

      expect(identical(factory1, factory2), isFalse);
    });

    test('different ToorFactorys create different instances of T', () {
      final toor = Toor.instance;

      final factory1 = toor.registerFactory(() => Object());
      final factory2 = toor.registerFactory(() => Object());

      expect(identical(factory1(), factory2()), isFalse);
    });
  });

  group('ToorLazySingleton', () {
    test('Returns the same instance of T on every call', () {
      final lazySingleton = Toor.instance.registerLazySingleton(() => Object());

      final firstCreatedObject = lazySingleton();
      for (int i = 0; i < 7; i++) {
        expect(identical(lazySingleton(), firstCreatedObject), isTrue);
      }
    });

    test('resets the current value', () {
      final lazySingleton = Toor.instance.registerLazySingleton(() => Object());

      final initialValue = lazySingleton();
      lazySingleton.reset();

      final valueAfterReset = lazySingleton();

      expect(identical(initialValue, valueAfterReset), isFalse);
    });
  });

  test('Toor.newInstance() creates a new instance', () {
    final defaultInstance = Toor.instance;
    final newInstance1 = Toor.newInstance();
    final newInstance2 = Toor.newInstance();

    expect(identical(defaultInstance, newInstance1), isFalse);
    expect(identical(defaultInstance, newInstance2), isFalse);
    expect(identical(newInstance1, newInstance2), isFalse);
  });
}
