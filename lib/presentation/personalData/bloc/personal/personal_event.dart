part of 'personal_bloc.dart';

@freezed
class PersonalEvent with _$PersonalEvent {
  const factory PersonalEvent.started() = _Started;
  const factory PersonalEvent.getPersonalData() = _GetPersonalData;
}
