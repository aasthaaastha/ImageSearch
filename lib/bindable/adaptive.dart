

part of '../mvvm.dart';

///
class AdaptiveBindableProperty<TValue, TAdaptee extends Listenable>
    extends CustomBindableProperty<TValue> {

  final TAdaptee adaptee;
  AdaptiveBindableProperty(this.adaptee,
      {required TValue Function(TAdaptee) valueGetter,
      void Function(TAdaptee, TValue)? valueSetter,
      PropertyValueChanged<TValue>? valueChanged})
      : super(
            valueGetter: () => valueGetter(adaptee),
            valueSetter:
                valueSetter == null ? null : (v) => valueSetter(adaptee, v),
            valueChanged: valueChanged) {
    adaptee.addListener(_valueChanged);
  }

  // check value
  void _valueChanged() => notifyListeners();

  @override
  void dispose() {
    adaptee.removeListener(_valueChanged);
    super.dispose();
  }
}
