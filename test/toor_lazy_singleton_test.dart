import 'package:test/test.dart';
import 'package:toor/toor.dart';

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

    test('Calls `onDispose` with actual object', () {
      /// Don't do it like this, use `mocktail` :).
      /// Just didn't wanna add a library for this single test case.
      bool didCall = false;

      final lazySingleton = Toor.instance.registerLazySingleton<List<int>>(
        () => [1984],
        onDispose: (value) {
          didCall = true;
          expect(value.length, 2);
        },
      );

      lazySingleton().add(1985);

      Toor.instance.reset();

      expect(didCall, true);
    });
  });
}
