import 'package:test/test.dart';
import 'package:toor/toor.dart';

void main() {
  group(
    'ToorFactory',
    () {
      test(
        'creates different instances of ToorLocator',
        () {
          final toor = Toor.instance;

          final factory1 = toor.registerFactory(() => Object());
          final factory2 = toor.registerFactory(() => Object());

          expect(identical(factory1, factory2), isFalse);
        },
      );

      test(
        'different ToorFactorys create different instances of T',
        () {
          final toor = Toor.instance;

          final factory1 = toor.registerFactory(() => Object());
          final factory2 = toor.registerFactory(() => Object());

          expect(identical(factory1(), factory2()), isFalse);
        },
      );
    },
  );

  test(
    'Toor.newInstance() creates a new instance',
    () {
      final defaultInstance = Toor.instance;
      final newInstance1 = Toor.newInstance();
      final newInstance2 = Toor.newInstance();

      expect(identical(defaultInstance, newInstance1), isFalse);
      expect(identical(defaultInstance, newInstance2), isFalse);
      expect(identical(newInstance1, newInstance2), isFalse);
    },
  );
}
