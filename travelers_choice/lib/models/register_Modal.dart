//     final registerModal = registerModalFromJson(jsonString);

import 'dart:convert';

RegisterModal registerModalFromJson(String str) =>
    RegisterModal.fromJson(json.decode(str));

String registerModalToJson(RegisterModal data) => json.encode(data.toJson());

class RegisterModal {
  RegisterModal({
    required this.newUser,
    required this.jwtToken,
  });

  NewUser newUser;
  String jwtToken;

  factory RegisterModal.fromJson(Map<String, dynamic> json) => RegisterModal(
        newUser: NewUser.fromJson(json["newUser"]),
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "newUser": newUser.toJson(),
        "jwtToken": jwtToken,
      };
}

class NewUser {
  NewUser({
    required this.name,
    required this.email,
    required this.isEmailVerified,
    required this.phoneNumber,
    required this.country,
    required this.balance,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String name;
  String email;
  bool isEmailVerified;
  String phoneNumber;
  String country;
  int balance;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
        name: json["name"],
        email: json["email"],
        isEmailVerified: json["isEmailVerified"],
        phoneNumber: json["phoneNumber"],
        country: json["country"],
        balance: json["balance"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "isEmailVerified": isEmailVerified,
        "phoneNumber": phoneNumber,
        "country": country,
        "balance": balance,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
