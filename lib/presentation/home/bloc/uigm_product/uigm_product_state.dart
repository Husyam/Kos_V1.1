part of 'uigm_product_bloc.dart';

@freezed
class UigmProductState with _$UigmProductState {
  const factory UigmProductState.initial() = _Initial;
  const factory UigmProductState.loading() = _Loading;
  const factory UigmProductState.loaded(List<Product> uigmProducts) = _Loaded;
  const factory UigmProductState.error(String message) = _Error;
}
