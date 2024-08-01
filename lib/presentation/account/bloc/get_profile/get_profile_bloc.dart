// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/models/responses/auth_response_model.dart';

part 'get_profile_bloc.freezed.dart';
part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final AuthRemoteDatasource authRemoteDatasource;
  GetProfileBloc(this.authRemoteDatasource)
      : super(const GetProfileState.initial()) {
    on<_GetProfile>((event, emit) async {
      emit(const GetProfileState.loading());
      final response = await authRemoteDatasource.getProfile(event.userId);
      response.fold(
        (l) {
          print('Error: $l'); // Logging error
          emit(GetProfileState.error(l));
        },
        (r) {
          if (r.user != null) {
            print('User data: ${r.user}'); // Logging user data
            emit(GetProfileState.loaded(r.user!));
          } else {
            emit(const GetProfileState.error("User data is null"));
          }
        },
      );
    });
  }
}
