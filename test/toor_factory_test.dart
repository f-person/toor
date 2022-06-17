import 'package:test/test.dart';

import 'package:toor/toor_test.dart';

import 'test_utils.dart';

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

    testFactoryReset(Toor.instance.registerFactory(() => Object()));
  });

  group('ToorFactoryWithOneParameter', () {
    test('uses the parameter as intended', () {
      final toor = Toor.instance;

      final stringFactory =
          toor.registerFactoryWithOneParameter<String, String>(
        (param1) => param1,
      );

      const shrug = r'¯\_(ツ)_/¯';
      final shruggingFactory =
          toor.registerFactoryWithOneParameter<String, String>(
        (param1) => '$param1 $shrug',
      );

      expect(stringFactory('Can you hear me?'), 'Can you hear me?');
      expect(
        shruggingFactory('Is this the real life?'),
        'Is this the real life? $shrug',
      );
    });

    testFactoryReset(
      Toor.instance.registerFactoryWithOneParameter((param1) => param1),
    );
  });

  group('ToorFactoryWithTwoParameters', () {
    test('uses the parameters as intended', () {
      final toor = Toor.instance;

      final wordJoinerFactory =
          toor.registerFactoryWithTwoParameters<String, Object, Object>(
        (param1, param2) => '$param1 $param2',
      );

      expect(wordJoinerFactory('Amor', 'Fati'), 'Amor Fati');
    });

    testFactoryReset(
      Toor.instance.registerFactoryWithTwoParameters(
        (param1, param2) => param1 == param2,
      ),
    );
  });
}
