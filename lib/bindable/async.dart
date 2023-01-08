

part of '../mvvm.dart';

class AsyncBindableProperty<TValue>
    extends BindableProperty<AsyncSnapshot<TValue>> {
  Object? _callbackIdentity;

  final AsyncValueGetter<TValue> _futureGetter;
  final TValue Function(TValue)? _handle;

  final void Function()? _onStart;
  final void Function()? _onEnd;
  final void Function(TValue)? _onSuccess;
  final void Function(dynamic)? _onError;
  AsyncBindableProperty(AsyncValueGetter<TValue> futureGetter,
      {TValue Function(TValue)? handle,
      void Function()? onStart,
      void Function()? onEnd,
      void Function(TValue)? onSuccess,
      void Function(dynamic)? onError,
      PropertyValueChanged<AsyncSnapshot<TValue>>? valueChanged,
      TValue? initial})
      : _futureGetter = futureGetter,
        _handle = handle,
        _onStart = onStart,
        _onEnd = onEnd,
        _onSuccess = onSuccess,
        _onError = onError,
        _value = initial == null
            ? AsyncSnapshot<TValue>.nothing()
            : AsyncSnapshot<TValue>.withData(ConnectionState.none, initial),
        super(valueChanged: valueChanged);
  AsyncSnapshot<TValue> _value;

  @override
  AsyncSnapshot<TValue> get value => _value;

  void _setValue(AsyncSnapshot<TValue> value) {
    if (value != _value) {
      _value = value;
      notifyListeners();
    }
  }

  @protected
  void invoke({bool resetOnBefore = true}) {
    if (resetOnBefore) {
      _setValue(AsyncSnapshot<TValue>.nothing());
    }

    var future = _futureGetter();
    _onStart?.call();
    final callbackIdentity = Object();
    _callbackIdentity = callbackIdentity;
    future.then<void>((TValue data) {
      if (_callbackIdentity == callbackIdentity) {
        var _data = _handle == null ? data : _handle!(data);
        _onSuccess?.call(_data);
        _setValue(AsyncSnapshot<TValue>.withData(ConnectionState.done, _data));
      }
      _onEnd?.call();
    }, onError: (Object error) {
      if (_callbackIdentity == callbackIdentity) {
        _setValue(AsyncSnapshot<TValue>.withError(ConnectionState.done, error));
        _onError?.call(error);
      }
      _onEnd?.call();
    });
    _setValue(value.inState(ConnectionState.waiting));
  }
}

mixin AsyncBindablePropertyMixin on BindableObjectMixin {

  void Function()? getInvoke(Object propertyKey, {bool resetOnBefore = true}) {
    var property = getPropertyOf<dynamic, AsyncBindableProperty>(propertyKey);
    return property != null
        ? () => property.invoke(resetOnBefore: resetOnBefore)
        : null;
  }

  void Function() requireInvoke(Object propertyKey,
      {bool resetOnBefore = true}) {
    return getInvoke(propertyKey, resetOnBefore: resetOnBefore)!;
  }


  void invoke(Object propertyKey, {bool resetOnBefore = true}) =>
      getInvoke(propertyKey, resetOnBefore: resetOnBefore)?.call();

  void Function()? link(Object propertyKey, {bool resetOnBefore = true}) =>
      getInvoke(propertyKey, resetOnBefore: resetOnBefore);
}
