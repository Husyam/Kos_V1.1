import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/responses/product_response_mode.dart';

part 'uin_product_event.dart';
part 'uin_product_state.dart';
part 'uin_product_bloc.freezed.dart';

class UinProductBloc extends Bloc<UinProductEvent, UinProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  UinProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<UinProductEvent>((event, emit) async {
      emit(const UinProductState.loading());
      final response = await _productRemoteDatasource.getProductByCategory(2);

      response.fold(
        (l) => emit(const UinProductState.error('Error fetching products')),
        (r) => emit(UinProductState.loaded(r.data!.data!)),
      );
    });
  }
}
