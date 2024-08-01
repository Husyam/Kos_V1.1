import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kos_mobile_v2_testing/data/datasources/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_mode.dart';

part 'bidar_product_event.dart';
part 'bidar_product_state.dart';
part 'bidar_product_bloc.freezed.dart';

class BidarProductBloc extends Bloc<BidarProductEvent, BidarProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  BidarProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetBidarProducts>((event, emit) async {
      emit(const BidarProductState.loading());
      final response = await _productRemoteDatasource.getProductByCategory(2);

      response.fold(
        (l) => emit(const BidarProductState.error('Error fetching products')),
        (r) => emit(BidarProductState.loaded(r.data!.data!)),
      );
    });
  }
}
