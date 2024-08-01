// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_remote_datasource.dart';

import '../../../../data/models/responses/auth_response_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource authRemoteDatasource;

  RegisterBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const RegisterState.loading());
      try {
        final response = await authRemoteDatasource.register(
            event.email, event.name, event.phone, event.password);
        response.fold(
          (l) => emit(RegisterState.error(l)),
          (r) => emit(RegisterState.loaded(r)),
        );
      } catch (e) {
        emit(RegisterState.error('Unexpected error occurred: $e'));
      }
    });
  }
}
