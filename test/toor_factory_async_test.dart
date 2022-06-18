import 'package:test/test.dart';

import 'package:toor/toor.dart';

import 'test_utils.dart';

void main() {
  group('ToorFactoryAsync', () {
    test('returns a new instance when called', () async {
      final objectFactory = Toor.instance.registerFactoryAsync(
        () async => Object(),
      );
      final object1 = await objectFactory();
      final object2 = await objectFactory();

      expect(identical(object1, object2), isFalse);
    });

    test('creates different instances of ToorLocatorAsync', () async {
      final toor = Toor.instance;

      final factory1 = toor.registerFactoryAsync(() async => Object());
      final factory2 = toor.registerFactoryAsync(() async => Object());

      expect(identical(factory1, factory2), isFalse);
    });

    test(
      'different ToorFactoryAsyncs create different instances of T',
      () async {
        final toor = Toor.instance;

        final factory1 = toor.registerFactoryAsync(() async => Object());
        final factory2 = toor.registerFactoryAsync(() async => Object());

        final object1 = await factory1();
        final object2 = await factory2();

        expect(identical(object1, object2), isFalse);
      },
    );
  });

  group('ToorFactoryAsyncWithOneParameter', () {
    test('uses the parameter as intended', () async {
      final asyncFactory = Toor.instance.registerFactoryAsyncWithOneParameter(
        (String string) async => '$string future',
      );

      expect(await asyncFactory('back to the'), 'back to the future');
    });

    testFactoryReset(Toor.instance.registerFactoryAsyncWithOneParameter(
      (Object obj) async => obj,
    ));
  });

  group('ToorFactoryAsyncWithTwoParameters', () {
    test('uses the parameters as intended', () async {
      final toor = Toor.instance;

      final wordJoinerFactory =
          toor.registerFactoryAsyncWithTwoParameters<String, Object, Object>(
        (param1, param2) async => '$param1 $param2',
      );

      expect(await wordJoinerFactory('Two', 'Words'), 'Two Words');
    });
  });
}
