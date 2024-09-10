part of 'unsri_product_bloc.dart';

@freezed
class UnsriProductEvent with _$UnsriProductEvent {
  const factory UnsriProductEvent.started() = _Started;
  const factory UnsriProductEvent.getUnsriProducts() = _GetUnsriProducts;
}
