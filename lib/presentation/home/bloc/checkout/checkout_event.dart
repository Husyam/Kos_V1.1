part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addItem(Product product) = _AddItem;
  const factory CheckoutEvent.removeItem(Product product) = _RemoveItem;
  //add personal data id
  const factory CheckoutEvent.addPersonalDataId(int personalDataId) =
      _AddPersonalDataId;
  //add payment method
  const factory CheckoutEvent.addPaymentMethod(String paymentMethod) =
      _AddPaymentMethod;
}
