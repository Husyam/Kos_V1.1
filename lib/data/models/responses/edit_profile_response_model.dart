import 'dart:convert';

class EditProfileResponseModel {
  final AccessToken? accessToken;
  final User? user;
  final String? message;

  EditProfileResponseModel({
    this.accessToken,
    this.user,
    this.message,
  });

  factory EditProfileResponseModel.fromJson(String str) =>
      EditProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      EditProfileResponseModel(
        accessToken: json["access_token"] == null
            ? null
            : AccessToken.fromMap(json["access_token"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken?.toMap(),
        "user": user?.toMap(),
        "message": message,
      };
}

class AccessToken {
  final int? id;
  final String? tokenableType;
  final int? tokenableId;
  final String? name;
  final List<String>? abilities;
  final DateTime? lastUsedAt;
  final dynamic expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? tokenable;

  AccessToken({
    this.id,
    this.tokenableType,
    this.tokenableId,
    this.name,
    this.abilities,
    this.lastUsedAt,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.tokenable,
  });

  factory AccessToken.fromJson(String str) =>
      AccessToken.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccessToken.fromMap(Map<String, dynamic> json) => AccessToken(
        id: json["id"],
        tokenableType: json["tokenable_type"],
        tokenableId: json["tokenable_id"],
        name: json["name"],
        abilities: json["abilities"] == null
            ? []
            : List<String>.from(json["abilities"]!.map((x) => x)),
        lastUsedAt: json["last_used_at"] == null
            ? null
            : DateTime.parse(json["last_used_at"]),
        expiresAt: json["expires_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        tokenable:
            json["tokenable"] == null ? null : User.fromMap(json["tokenable"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tokenable_type": tokenableType,
        "tokenable_id": tokenableId,
        "name": name,
        "abilities": abilities == null
            ? []
            : List<dynamic>.from(abilities!.map((x) => x)),
        "last_used_at": lastUsedAt?.toIso8601String(),
        "expires_at": expiresAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tokenable": tokenable?.toMap(),
      };
}

class User {
  final int? idUser;
  final String? name;
  final String? email;
  final String? fcmId;
  final String? phone;
  final String? roles;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.idUser,
    this.name,
    this.email,
    this.fcmId,
    this.phone,
    this.roles,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        name: json["name"],
        email: json["email"],
        fcmId: json["fcm_id"],
        phone: json["phone"],
        roles: json["roles"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "fcm_id": fcmId,
        "phone": phone,
        "roles": roles,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
