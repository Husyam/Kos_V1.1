import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_remote_datasource.dart';

part 'forgot_event.dart';
part 'forgot_state.dart';
part 'forgot_bloc.freezed.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  final AuthRemoteDatasource authRemoteDatasource;
  ForgotBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_ForgotPassword>((event, emit) async {
      emit(const ForgotState.loading());
      try {
        final response = await authRemoteDatasource.forgotPassword(event.email);
        response.fold(
          (l) => emit(ForgotState.error(l)),
          (r) => emit(const ForgotState.loaded()),
        );
      } catch (e) {
        emit(ForgotState.error('Unexpected error occurred: $e'));
      }
    });
  }
}
