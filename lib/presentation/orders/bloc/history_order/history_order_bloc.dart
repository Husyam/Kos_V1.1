// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kos_mobile_v2_testing/data/models/responses/history_order_response_model.dart';

import '../../../../data/datasources/order_remote_datasource.dart';

part 'history_order_bloc.freezed.dart';
part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  HistoryOrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_HistoryOrder>((event, emit) async {
      emit(const _Loading());
      final response = await orderRemoteDatasource.getOrders();
      response.fold(
        (l) => emit(const _Error('Error')),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
