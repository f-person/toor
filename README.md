[![codecov](https://codecov.io/gh/f-person/toor/branch/master/graph/badge.svg)](https://codecov.io/gh/f-person/toor)

# 🌱 What is Toor
Toor makes service locators compile-time safe and easy to manage.

## 🚀 Getting Started

Define your dependencies somewhere in the project.
It is recommended to make your locators lazily initialized via using
the `late` keyword so that they are created only when used.

```dart
final toor = Toor.instance;

late final httpClientSingleton = toor.registerLazySingleton<IHttpClient>(
  DioHttpClientImpl.new,
);

late final authRepositoryFactory = toor.registerFactory<IAuthRepository>(
  () => AuthRepositoryImpl(httpClient: httpClientSingleton()),
);
```

After that, you can safely access your registered factories or lazy singletons:
```dart
void authenticate(String email, String password) {
  authRepositoryFactory().authenticate(email, password);
}
```

## ✨ Toor in detail
### Types of locators 
Toor currently supports two types of objects: factories and lazy singletons.

#### Factory
Factories are locators that are created on each time you get them.

Use `Toor.registerFactory` to create factory locators:

```dart
final toor = Toor.instance;

late final authRepositoryFactory = toor.registerFactory<IAuthRepository>(
  AuthRepositoryImpl.new,
);
```

#### Lazy Singleton
Lazy singletons are locators that are created only on the first call.
The object, created at the first call, will be returned every time you get
it afterwards.

Use `Toor.registerLazySingleton` to create lazy singleton locators:

```dart
final toor = Toor.instance;

late final credentialManager = toor.registerLazySingleton<ICredentialManager>(
  CredentialManagerImpl.new,
);
```

#### Async Factory
Async factories are locators that are asynchronously created each time you get them.

Use `Toor.registerFactoryAsync` to create async factory locators:

```dart
final toor = Toor.instance;

late final dataPersisterFactory = toor.registerFactoryAsync<IDataPersister>(
  () async => SharedPreferencesDataPersister(
    sharedPreferences: await SharedPreferences.getInstance(),
  ),
);
```

Await the creation of your factory to obtain and use it:

```dart
final dataPersister = await dataPersisterFactory();
dataPersister.saveData('big');
```

#### Factories with parameters

You can also create factories that accept 1 or 2 parameters:

```dart
final toor = Toor.instance;

final personFactory = toor.registerFactoryWithOneParameter<Person, String>(
  (name) => Person(name),
);

final vehicleFactory = toor.registerFactoryWithTwoParameters<Vehicle, String, int>(
  (name, productionYear) => Vehicle(name, productionYear);
);

class Person {
  const Person(this.name);

  final String name;
}

class Vehicle {
  const Vehicle(this.name, this.productionYear);

  final String name;
  final int productionYear;
}

void main() {
  // Both are compile-time safe and know about the types.
  final driver = personFactory('Doc');
  final vehicle = vehicleFactory('DeLorean', 1981);
}
```

Async factories are also supported via `registerFactoryAsyncWithOneParameter`
and `registerFactoryAsyncWithTwoParameters`.

### Advanced usage

#### Resetting lazy singletons 
You can reset lazy singletons via the `reset` method. This will delete the
current object and create a new one on the next call.

```dart
final toor = Toor.instance;

String value = 'Initial';

late final lazySingleton = toor.registerLazySingleton<String>(
  () => value,
);

// Even though we change the `value` variable here,
// `lazySingleton`s value will remain 'Initial'.
value = 'Changed';

print(lazySingleton()); // 'Initial'

// Once we reset `lazySingleton`, it's value will be 'Changed' on the next call.
lazySingleton.reset();

print(lazySingleton()); // 'Changed'
```

#### Resetting all lazy singletons
Toor lets you reset all lazy singletons at once via the `reset` method on its
instance. This will call `reset` on every lazy singleton, registered with it.

```dart
final toor = Toor.instance;

String value = 'Initial';

late final lazySingleton = toor.registerLazySingleton<String>(
  () => value,
);

value = 'Changed';

print(lazySingleton()); // 'Initial'

// Once we reset `toor`, all lazy singletons, registered via
// `toor.registerLazySingleton` will be reset.
toor.reset();

print(lazySingleton()); // 'Changed'
```

#### Creating new instances of Toor
You may want to create several instances of Toor, independent of each other.
The `Toor.instance` getter will return the default instance but you don't
have to use it. You can create new instances of Toor via `Toor.newInstance()`.
You may want to do this in order to reset lazy singletons, related to a
single domain (e.g. reset all singletons that hold user data on logout).

```dart
final authToor = Toor.newInstance();
final analyticsToor = Toor.newInstance();

late final credentialManager = authToor.registerLazySingleton<ICredentialManager>(
  CredentialManagerImpl.new,
);

late final sessionRecorder = authToor.registerLazySingleton<ISessionRecorder>(
  SessionRecorderImpl(upload: false),
);

void logout() {
  // `credentialManager` will be reset, however `sessionRecorder` won't, since
  // it's registered in `analyticsToor`, not `authToor`.
  authToor.reset();
}
```

## 🧪 Testing with Toor
Sometimes, you need different (e.g. mock) objects to be created in tests.
There are two ways to achieve that with Toor:
1. Deciding what to register based on some variables / other toor singletons
(e. g. flavor):
```dart
final toor = Toor.instance;

late final authManager = toor.registerLazySingleton<IAuthManager>(
  flavor.isTesting ? MockAuthManager() : AuthManagerImpl(),
);
```
2. Overriding registered objects via `override` which is
available in `toor_test`. The `override` method is annotated with
`visibleForTesting` since it's intended to be used only in tests:
```dart
// dependencies.dart
import 'package:toor/toor.dart';

final toor = Toor.instance;

late final authManager = toor.registerLazySingleton<IAuthManager>(
  AuthManagerImpl.new,
);
```

```dart
// app_test.dart
import 'package:toor/toor_test.dart';

void main() {
  setUpAll(() {
    authManager.override(() => MockAuthManager());
  });
}
```