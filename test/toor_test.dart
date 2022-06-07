import 'dart:developer';
import 'dart:isolate';

import 'package:test/test.dart';
import 'package:toor/toor.dart';
import 'package:vm_service/vm_service_io.dart';

void main() {
  test('Toor.newInstance() creates a new instance', () {
    final defaultInstance = Toor.instance;
    final newInstance1 = Toor.newInstance();
    final newInstance2 = Toor.newInstance();

    expect(identical(defaultInstance, newInstance1), isFalse);
    expect(identical(defaultInstance, newInstance2), isFalse);
    expect(identical(newInstance1, newInstance2), isFalse);
  });

  group('Toor.reset', () {
    test('resets lazy singletons', () {
      final toor = Toor.instance;

      final lazySingleton1 = toor.registerLazySingleton(() => Object());
      final lazySingleton2 = toor.registerLazySingleton(() => Object());

      final initialResult1 = lazySingleton1();
      final initialResult2 = lazySingleton2();

      expect(lazySingleton1(), initialResult1);
      expect(lazySingleton2(), initialResult2);

      toor.reset();

      expect(lazySingleton1(), isNot(initialResult1));
      expect(lazySingleton2(), isNot(initialResult2));
    });

    test('does not break when deleting the lazy singleton object', () async {
      final toor = Toor.newInstance();

      ToorLocator<int>? lazySingleton = toor.registerLazySingleton(
        () => 12,
      );
      expect(lazySingleton(), lazySingleton());
      lazySingleton = null;

      await _triggerGarbageCollection();

      expect(toor.reset, isNot(throwsException));
    });
  });
}

/// It's necessary to trigger garbage collection in order to be sure
/// that deleting the reference to a lazy singleton does not break anything.
Future<void> _triggerGarbageCollection() async {
  List<String> _cleanupPathSegments(Uri uri) {
    final pathSegments = <String>[];
    if (uri.pathSegments.isNotEmpty) {
      pathSegments.addAll(uri.pathSegments.where(
        (s) => s.isNotEmpty,
      ));
    }
    return pathSegments;
  }

  String _toWebSocket(Uri uri) {
    final pathSegments = _cleanupPathSegments(uri);
    pathSegments.add('ws');
    return uri.replace(scheme: 'ws', pathSegments: pathSegments).toString();
  }

  final serverUri = (await Service.getInfo()).serverUri!;
  final isolateId = Service.getIsolateID(Isolate.current)!;
  final vmService = await vmServiceConnectUri(_toWebSocket(serverUri));
  await vmService.getAllocationProfile(isolateId, gc: true);
}
