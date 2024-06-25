part of 'bidar_product_bloc.dart';

@freezed
class BidarProductState with _$BidarProductState {
  const factory BidarProductState.initial() = _Initial;
  const factory BidarProductState.loading() = _Loading;
  const factory BidarProductState.loaded(List<Product> bidarProducts) = _Loaded;
  const factory BidarProductState.error(String message) = _Error;
}
