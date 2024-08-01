part of 'status_order_bloc.dart';

@freezed
class StatusOrderEvent with _$StatusOrderEvent {
  const factory StatusOrderEvent.started() = _Started;
  //chech payment status
  const factory StatusOrderEvent.checkPaymentStatus(int orderId) =
      _CheckPaymentStatus;
}
