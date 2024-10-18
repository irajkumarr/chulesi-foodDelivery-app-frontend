// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String fcm;
  final String email;
  final String password;

  RegistrationModel({
    required this.fcm,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        fcm: json["fcm"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "fcm": fcm,
        "email": email,
        "password": password,
      };
}
