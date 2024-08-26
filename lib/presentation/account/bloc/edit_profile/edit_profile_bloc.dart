// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kos_mobile_v2_testing/data/datasources/auth_edit_profile_datasource.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/edit_profile_response_model.dart';

part 'edit_profile_bloc.freezed.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AuthEditProfileDatasource authEditProfileDatasource;
  EditProfileBloc(
    this.authEditProfileDatasource,
  ) : super(const _Initial()) {
    on<_UpdateProfile>(
      (event, emit) async {
        emit(const _Loading());
        final response = await authEditProfileDatasource.updateProfile(
          event.name,
          event.email,
          event.phone,
          event.password,
        );
        response.fold(
          (l) => emit(EditProfileState.error(l)),
          (r) => emit(EditProfileState.loaded(r.user!)),
        );
      },
    );
  }
}
