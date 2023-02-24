// To parse this JSON data, do
//
//     final updateProfileModal = updateProfileModalFromJson(jsonString);

import 'dart:convert';

UpdateProfileModal updateProfileModalFromJson(String str) => UpdateProfileModal.fromJson(json.decode(str));

String updateProfileModalToJson(UpdateProfileModal data) => json.encode(data.toJson());

class UpdateProfileModal {
  UpdateProfileModal({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    required this.phoneNumber,
    required this.country,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  String email;
  bool isEmailVerified;
  String phoneNumber;
  String country;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory UpdateProfileModal.fromJson(Map<String, dynamic> json) => UpdateProfileModal(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    phoneNumber: json["phoneNumber"],
    country: json["country"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "phoneNumber": phoneNumber,
    "country": country,
    "balance": balance,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
