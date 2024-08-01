// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// 'name' => $request->name,
//             'gender'=> $request->gender,
//             'profession'=> $request->profession,
//             'contact'=> $request->contact,
//             'user_id'=> $request->user()->id,
//             'is_default'=> $request->is_default,

class PersonalRequestModel {
  final String? name;
  final String? gender;
  final String? profession;
  final String? contact;
  final int? isDefault;

  PersonalRequestModel({
    this.name,
    this.gender,
    this.profession,
    this.contact,
    this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gender': gender,
      'profession': profession,
      'contact': contact,
      // 'is_Default': isDefault,
      'is_default': isDefault
    };
  }

  factory PersonalRequestModel.fromMap(Map<String, dynamic> map) {
    return PersonalRequestModel(
      name: map['name'],
      gender: map['gender'],
      profession: map['profession'],
      contact: map['contact'],
      isDefault: map['is_default']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalRequestModel.fromJson(String source) =>
      PersonalRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
