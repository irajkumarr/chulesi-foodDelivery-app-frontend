// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  final String fcm;
  final String phone;
  final bool verification;
  final String userType;
  // final dynamic profile;
  final String userToken;

  LoginResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
    required this.fcm,
    required this.phone,
    required this.verification,
    required this.userType,
    // required this.profile,
    required this.userToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        uid: json["uid"],
        fcm: json["fcm"],
        phone: json["phone"],
        verification: json["verification"],
        userType: json["userType"],
        // profile: json["profile"],
        userToken: json["userToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "uid": uid,
        "fcm": fcm,
        "phone": phone,
        "verification": verification,
        "userType": userType,
        // "profile": profile,
        "userToken": userToken,
      };
}
// // To parse this JSON data, do
// //
// //     final loginResponse = loginResponseFromJson(jsonString);

// import 'dart:convert';

// LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

// String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

// class LoginResponse {
//     String? id;
//     String? firstName;
//     String? lastName;
//     String? email;
//     String? uid;
//     String? fcm;
//     String? phone;
//     bool? verification;
//     String? userType;
//     dynamic profile;
//     String? userToken;

//     LoginResponse({
//         this.id,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.uid,
//         this.fcm,
//         this.phone,
//         this.verification,
//         this.userType,
//         this.profile,
//         this.userToken,
//     });

//     factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         email: json["email"],
//         uid: json["uid"],
//         fcm: json["fcm"],
//         phone: json["phone"],
//         verification: json["verification"],
//         userType: json["userType"],
//         profile: json["profile"],
//         userToken: json["userToken"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "uid": uid,
//         "fcm": fcm,
//         "phone": phone,
//         "verification": verification,
//         "userType": userType,
//         "profile": profile,
//         "userToken": userToken,
//     };
// }
