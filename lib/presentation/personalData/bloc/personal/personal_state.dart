part of 'personal_bloc.dart';

@freezed
class PersonalState with _$PersonalState {
  const factory PersonalState.initial() = _Initial;
  const factory PersonalState.loading() = _Loading;
  const factory PersonalState.error(String message) = _Error;
  const factory PersonalState.loaded(List<Personal> personal) = _Loaded;
}
