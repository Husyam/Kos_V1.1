// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/responses/product_response_mode.dart';

part 'uigm_product_bloc.freezed.dart';
part 'uigm_product_event.dart';
part 'uigm_product_state.dart';

class UigmProductBloc extends Bloc<UigmProductEvent, UigmProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  UigmProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetUigmProducts>((event, emit) async {
      emit(const UigmProductState.loading());
      final response = await _productRemoteDatasource.getProductByCategory(2);
      response.fold(
        (l) => emit(const UigmProductState.error('Error fetching products')),
        (r) => emit(UigmProductState.loaded(r.data!.data!)),
      );
    });
  }
}
