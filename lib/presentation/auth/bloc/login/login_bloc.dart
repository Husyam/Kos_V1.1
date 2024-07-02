// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kos_mobile_v2_testing/data/datasources/auth_remote_datasource.dart';

import '../../../../data/models/responses/auth_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());
      final response =
          await authRemoteDatasource.login(event.email, event.password);
      response.fold(
        (l) => emit(LoginState.error(l)),
        (r) => emit(LoginState.loaded(r)),
      );
    });
  }
}
