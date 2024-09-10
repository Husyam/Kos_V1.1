part of 'uigm_product_bloc.dart';

@freezed
class UigmProductEvent with _$UigmProductEvent {
  const factory UigmProductEvent.started() = _Started;
  const factory UigmProductEvent.getUigmProducts() = _GetUigmProducts;
}
