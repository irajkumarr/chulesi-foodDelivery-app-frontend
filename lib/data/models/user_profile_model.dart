// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    final String firstName;
    final String lastName;
    final String email;
    final String phone;

    UserProfileModel({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
    };
}
