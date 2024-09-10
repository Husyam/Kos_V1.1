part of 'unsri_product_bloc.dart';

@freezed
class UnsriProductState with _$UnsriProductState {
  const factory UnsriProductState.initial() = _Initial;
  const factory UnsriProductState.loading() = _Loading;
  const factory UnsriProductState.loaded(List<Product> unsriProducts) = _Loaded;
  const factory UnsriProductState.error(String message) = _Error;
}
