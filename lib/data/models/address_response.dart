// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

List<AddressResponse> addressResponseFromJson(String str) =>
    List<AddressResponse>.from(
        json.decode(str).map((x) => AddressResponse.fromJson(x)));

String addressResponseToJson(List<AddressResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressResponse {
  final String id;
  final String userId;
  final String addressTitle;
  final String location;
  final String customerName;
  final String phone;
  final double latitude;
  final double longitude;
  final String deliveryInstructions;
  final String addressResponseDefault;
  final int v;

  AddressResponse({
    required this.id,
    required this.userId,
    required this.addressTitle,
    required this.location,
    required this.customerName,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.deliveryInstructions,
    required this.addressResponseDefault,
    required this.v,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["_id"],
        userId: json["userId"],
        addressTitle: json["addressTitle"],
        location: json["location"],
        customerName: json["customerName"],
        phone: json["phone"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        deliveryInstructions: json["deliveryInstructions"],
        addressResponseDefault: json["default"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "addressTitle": addressTitle,
        "location": location,
        "customerName": customerName,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "deliveryInstructions": deliveryInstructions,
        "default": addressResponseDefault,
        "__v": v,
      };
}
