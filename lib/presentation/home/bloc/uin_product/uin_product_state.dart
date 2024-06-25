part of 'uin_product_bloc.dart';

@freezed
class UinProductState with _$UinProductState {
  const factory UinProductState.initial() = _Initial;
  const factory UinProductState.loading() = _Loading;
  const factory UinProductState.loaded(List<Product> uinProducts) = _Loaded;
  const factory UinProductState.error(String message) = _Error;
}
