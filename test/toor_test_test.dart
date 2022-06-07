import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:toor/toor.dart';

void main() {
  group(
    'Override',
    () {
      test(
        'overrides factories',
        () {
          const testValue1 = 1984;
          const testValue2 = 451;

          final testFactory =
              Toor.instance.registerFactory<int>(() => testValue1);

          expect(testFactory(), testValue1);
          testFactory.override(() => testValue2);
          expect(testFactory(), testValue2);
        },
      );
    },
  );
}
