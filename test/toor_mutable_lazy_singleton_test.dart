import 'package:test/test.dart';
import 'package:toor/toor.dart';

void main() {
  group('ToorMutableLazySingleton', () {
    test('changes the value', () {
      final mutableSingleton = Toor.instance.registerMutableLazySingleton(
        create: () => 'Artsakh',
      );

      expect(mutableSingleton(), 'Artsakh');

      mutableSingleton.put('Armenia');
      expect(mutableSingleton(), 'Armenia');
    });

    test('works with a default value of null', () {
      final mutableSingleton =
          Toor.instance.registerMutableLazySingleton<int>();

      expect(
        mutableSingleton.get,
        throwsA(isA<ToorUninitializedMutableSingletonException<int>>()),
      );

      mutableSingleton.put(451);

      expect(mutableSingleton(), 451);
    });

    test(
      'ToorUninitializedMutableSingletonException contains the type of the singleton',
      () {
        final mutableSingleton =
            Toor.instance.registerMutableLazySingleton<Iterable<String>>();

        expect(
          mutableSingleton.get,
          throwsA(
            predicate(
              (exception) => exception.toString().contains('Iterable<String>'),
            ),
          ),
        );
      },
    );

    test('resets the value to the initial one', () {
      final mutableSingleton = Toor.instance.registerMutableLazySingleton(
        create: () => 123,
      );
      mutableSingleton.put(664);
      mutableSingleton.reset();

      expect(mutableSingleton(), 123);
    });
  });
}
