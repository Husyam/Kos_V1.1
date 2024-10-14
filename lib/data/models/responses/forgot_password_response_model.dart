import 'dart:convert';

class ForgotPasswordResponseModel {
  final String? message;

  ForgotPasswordResponseModel({
    this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(String str) =>
      ForgotPasswordResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForgotPasswordResponseModel.fromMap(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
