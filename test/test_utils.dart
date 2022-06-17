import 'package:test/test.dart';

import 'package:toor/toor.dart';

void testFactoryReset(ResettableLocator locator) {
  test('reset does not throw anything', () {
    expect(locator.reset, isNot(throwsException));
  });
}
