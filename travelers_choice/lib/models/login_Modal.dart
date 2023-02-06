// To parse this JSON data, do
//
//     final loginModal = loginModalFromJson(jsonString);

import 'dart:convert';

LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  LoginModal({
    required this.user,
    required this.jwtToken,
  });

  User user;
  String jwtToken;

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
        user: User.fromJson(json["user"]),
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "jwtToken": jwtToken,
      };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
