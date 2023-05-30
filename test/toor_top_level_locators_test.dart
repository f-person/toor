import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:toor/toor.dart';

void main() {
  final toor = Toor.instance;

  group('Top level function creates locator correctly', () {
    test('and using toor global instance [registerLazySingleton]', () {
      final locator = registerLazySingleton(() => _Service());

      final currentInstance = locator();
      expect(currentInstance, equals(locator()));

      toor.reset();
      expect(identical(currentInstance, locator()), isFalse);
    });

    test('[registerFactory]', () {
      final locator = registerFactory(() => _Service());
      expect(identical(locator(), locator()), isFalse);
    });

    test('[registerFactoryWithParam]', () {
      final locator = registerFactoryWithParam((p) => _Service(firstArg: p));

      const param = "qwerty";
      final currentInstance = locator(param);
      final secondInstance = locator(param);

      expect(currentInstance, equals(secondInstance));
      expect(identical(currentInstance, secondInstance), isFalse);
    });

    test('[registerFactoryWithTwoParams]', () {
      final locator = registerFactoryWithTwoParams(
          (p, p2) => _Service(firstArg: p, secondArg: p2));

      const param1 = "qwerty";
      const param2 = "asdf";
      final currentInstance = locator(param1, param2);
      final secondInstance = locator(param1, param2);

      expect(currentInstance, equals(secondInstance));
      expect(identical(currentInstance, secondInstance), isFalse);
    });

    test('[registerFactoryAsync]', () async {
      final locator = registerFactoryAsync(() async => _Service());
      expect(identical(await locator(), await locator()), isFalse);
    });

    test('[registerFactoryAsyncWithParam]', () async {
      final locator =
          registerFactoryAsyncWithParam((p) async => _Service(firstArg: p));

      const param = "qwerty";
      final currentInstance = await locator(param);
      final secondInstance = await locator(param);

      expect(currentInstance, equals(secondInstance));
      expect(identical(currentInstance, secondInstance), isFalse);
    });

    test('[registerFactoryAsyncWithTwoParams]', () async {
      final locator = registerFactoryAsyncWithTwoParams(
        (p, p2) async => _Service(firstArg: p, secondArg: p2),
      );

      const param1 = "qwerty";
      const param2 = "asdf";
      final currentInstance = await locator(param1, param2);
      final secondInstance = await locator(param1, param2);

      expect(currentInstance, equals(secondInstance));
      expect(identical(currentInstance, secondInstance), isFalse);
    });

    test('[registerMutableLazySingleton]', () {
      final initialService = _Service(
        firstArg: 'Hey',
        secondArg: "We're chained",
      );
      final mutatedService = _Service(
        firstArg: 'Hey',
        secondArg: "We're not chained (lol)",
      );
      final locator = registerMutableLazySingleton(
        create: () => initialService,
      );
      expect(locator(), initialService);

      locator.put(mutatedService);
      expect(locator(), mutatedService);
    });
  });
}

class _Service<T, Q> {
  _Service({this.firstArg, this.secondArg});

  final T? firstArg;
  final Q? secondArg;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _Service &&
            firstArg == other.firstArg &&
            secondArg == other.secondArg;
  }

  @override
  int get hashCode => Object.hash(firstArg, secondArg);
}
