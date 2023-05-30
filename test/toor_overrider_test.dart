import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:toor/toor.dart';
import 'package:toor/toor_test.dart';

void main() {
  group('Override', () {
    test('overrides factories', () {
      const initialObject = 1984;
      const overridenObject = 451;

      final testFactory = Toor.instance.registerFactory<int>(
        () => initialObject,
      );

      expect(testFactory(), initialObject);
      testFactory.override(() => overridenObject);
      expect(testFactory(), overridenObject);
    });

    test('overrides lazy singletons', () {
      final initialObject = 12;
      final overridenObject = 23;

      final lazySingleton = Toor.instance.registerLazySingleton(
        () => initialObject,
      );

      expect(lazySingleton(), initialObject);
      lazySingleton.override(() => overridenObject);
      expect(lazySingleton(), overridenObject);
    });
  });
}
