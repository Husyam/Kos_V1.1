import 'dart:convert';

class PersonalResponseModel {
  final String? status;
  final List<Personal>? data;

  PersonalResponseModel({
    this.status,
    this.data,
  });

  factory PersonalResponseModel.fromJson(String str) =>
      PersonalResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalResponseModel.fromMap(Map<String, dynamic> json) =>
      PersonalResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Personal>.from(
                json["data"]!.map((x) => Personal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Personal {
  final int? idPersonalData;
  final String? name;
  final String? gender;
  final String? profession;
  final String? contact;
  final int? userId;
  final int? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Personal({
    this.idPersonalData,
    this.name,
    this.gender,
    this.profession,
    this.contact,
    this.userId,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Personal.fromJson(String str) => Personal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Personal.fromMap(Map<String, dynamic> json) => Personal(
        idPersonalData: json["id_personal_data"],
        name: json["name"],
        gender: json["gender"],
        profession: json["profession"],
        contact: json["contact"],
        userId: json["user_id"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id_personal_data": idPersonalData,
        "name": name,
        "gender": gender,
        "profession": profession,
        "contact": contact,
        "user_id": userId,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
