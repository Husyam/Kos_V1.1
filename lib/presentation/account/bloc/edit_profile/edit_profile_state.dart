part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  //loaded
  const factory EditProfileState.loaded(User profile) = _Loaded;
  //loading
  const factory EditProfileState.loading() = _Loading;
  //error
  const factory EditProfileState.error(String message) = _Error;
}
