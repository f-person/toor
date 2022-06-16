part of '../toor.dart';

class _ToorFactoryImpl<T> extends ToorLocator<T> {
  _ToorFactoryImpl(this.factoryFunc);

  late FactoryFunc<T> factoryFunc;

  @override
  T get() => factoryFunc();
}

class _ToorFactoryWithOneParameterImpl<T, P1>
    extends ToorLocatorWithOneParameter<T, P1> {
  _ToorFactoryWithOneParameterImpl(this.factoryFunc);

  late FactoryFuncWithOneParameter<T, P1> factoryFunc;

  @override
  T get(P1 param1) => factoryFunc(param1);
}

class _ToorFactoryWithTwoParametersImpl<T, P1, P2>
    extends ToorLocatorWithTwoParameters<T, P1, P2> {
  _ToorFactoryWithTwoParametersImpl(this.factoryFunc);

  late FactoryFuncWithTwoParameters<T, P1, P2> factoryFunc;

  @override
  T get(P1 param1, P2 param2) => factoryFunc(param1, param2);
}

class _ToorFactoryAsyncImpl<T> extends ToorLocatorAsync<T> {
  _ToorFactoryAsyncImpl(this.factoryFunc);

  late FactoryFuncAsync<T> factoryFunc;

  @override
  Future<T> get() => factoryFunc();
}

class _ToorFactoryAsyncWithOneParameterImpl<T, P1>
    extends ToorLocatorAsyncWithOneParameter<T, P1> {
  _ToorFactoryAsyncWithOneParameterImpl(this.factoryFunc);

  late FactoryFuncAsyncWithOneParameter<T, P1> factoryFunc;

  @override
  Future<T> get(P1 param1) => factoryFunc(param1);
}

class _ToorFactoryAsyncWithTwoParametersImpl<T, P1, P2>
    extends ToorLocatorAsyncWithTwoParameters<T, P1, P2> {
  _ToorFactoryAsyncWithTwoParametersImpl(this.factoryFunc);

  late FactoryFuncAsyncWithTwoParameters<T, P1, P2> factoryFunc;

  @override
  Future<T> get(P1 param1, P2 param2) => factoryFunc(param1, param2);
}
