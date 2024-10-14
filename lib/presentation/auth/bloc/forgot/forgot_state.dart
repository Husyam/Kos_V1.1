part of 'forgot_bloc.dart';

@freezed
class ForgotState with _$ForgotState {
  const factory ForgotState.initial() = _Initial;
  const factory ForgotState.loading() = _Loading;
  //loaded
  const factory ForgotState.loaded() = _Loaded;
  //error
  const factory ForgotState.error(String message) = _Error;
}
