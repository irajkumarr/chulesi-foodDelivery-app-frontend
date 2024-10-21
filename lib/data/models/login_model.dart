// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String email;
  final String password;
  final String fcm;

  LoginModel({
    required this.email,
    required this.password,
    required this.fcm,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
        fcm: json["fcm"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcm": fcm,
      };
}
