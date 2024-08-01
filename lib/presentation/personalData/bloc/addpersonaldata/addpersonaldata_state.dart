part of 'addpersonaldata_bloc.dart';

@freezed
class AddpersonaldataState with _$AddpersonaldataState {
  const factory AddpersonaldataState.initial() = _Initial;
  const factory AddpersonaldataState.loading() = _Loading;
  const factory AddpersonaldataState.error(String message) = _Error;
  const factory AddpersonaldataState.loaded() = _Loaded;
}
