// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.id,
    required this.name,
    required this.phone,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    required this.address,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String phone;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String address;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        address: json["address"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "address": address,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
