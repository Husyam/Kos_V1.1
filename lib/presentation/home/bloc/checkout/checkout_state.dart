part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  const factory CheckoutState.loaded(
    List<ProductQuantity> products,
    int personalDataId,
    String paymentVaName,
    String paymentMethod,
  ) = _Loaded;
  const factory CheckoutState.error(String message) = _Error;
}
