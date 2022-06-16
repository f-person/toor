import 'package:test/test.dart';
import 'package:toor/toor_test.dart';

void main() {
  void testFactoryReset(ResettableLocator locator) {
    test('reset does not throw anything', () {
      expect(locator.reset, isNot(throwsException));
    });
  }

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
    test('uses the parameter as intended', () {
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
}
