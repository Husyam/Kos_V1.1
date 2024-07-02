part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  //loaded
  const factory LoginState.loaded(AuthResponseModel authResponseModel) =
      _Loaded;
  //error
  const factory LoginState.error(String message) = _Error;
}
