// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/responses/product_response_mode.dart';

part 'unsri_product_bloc.freezed.dart';
part 'unsri_product_event.dart';
part 'unsri_product_state.dart';

class UnsriProductBloc extends Bloc<UnsriProductEvent, UnsriProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  UnsriProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<UnsriProductEvent>((event, emit) async {
      emit(const UnsriProductState.loading());
      final response = await _productRemoteDatasource.getProductByCategory(4);

      response.fold(
        (l) => emit(const UnsriProductState.error('Error fetching products')),
        (r) => emit(UnsriProductState.loaded(r.data!.data!)),
      );
    });
  }
}
