part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.started() = _Started;
  //update profile name, email, phone, and password
  const factory EditProfileEvent.updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) = _UpdateProfile;
}
