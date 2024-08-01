part of 'addpersonaldata_bloc.dart';

@freezed
class AddpersonaldataEvent with _$AddpersonaldataEvent {
  const factory AddpersonaldataEvent.started() = _Started;
  const factory AddpersonaldataEvent.addPersonalData({
    required PersonalRequestModel personalRequestModel,
  }) = _AddPersonalData;
}
