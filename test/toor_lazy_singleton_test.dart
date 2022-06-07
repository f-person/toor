import 'package:test/test.dart';
import 'package:toor/toor_test.dart';

void main() {
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
}
