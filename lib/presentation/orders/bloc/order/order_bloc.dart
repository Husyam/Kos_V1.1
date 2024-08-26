// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kos_mobile_v2_testing/data/datasources/order_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/data/models/requests/order_request_model.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/order_response_model.dart';

import '../../../home/models/product_quantity.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  OrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_DoOrder>((event, emit) async {
      emit(const OrderState.loading());

      final orderRequestData = OrderRequestModel(
        idPersonalData: event.personalDataId,
        paymentMethod: event.paymentMethod,
        paymentVaName: event.paymentVaName,
        subTotal: 0,
        totalCost: 0,
        items: event.products
            .map((e) =>
                Item(idProduct: e.product.idProduct!, quantity: e.quantity))
            .toList(),
      );
      final response = await orderRemoteDatasource.order(orderRequestData);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
