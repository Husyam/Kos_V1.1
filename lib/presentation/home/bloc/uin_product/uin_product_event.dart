part of 'uin_product_bloc.dart';

@freezed
class UinProductEvent with _$UinProductEvent {
  const factory UinProductEvent.started() = _Started;
  const factory UinProductEvent.getUinProducts() = _GetUinProducts;
}
