part of 'bidar_product_bloc.dart';

@freezed
class BidarProductEvent with _$BidarProductEvent {
  const factory BidarProductEvent.started() = _Started;
  const factory BidarProductEvent.getBidarProducts() = _GetBidarProducts;
}
