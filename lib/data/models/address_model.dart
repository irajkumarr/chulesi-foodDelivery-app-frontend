// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    final String addressTitle;
    final String location;
    final String customerName;
    final String phone;
    final double longitude;
    final double latitude;
    final String deliveryInstructions;

    AddressModel({
        required this.addressTitle,
        required this.location,
        required this.customerName,
        required this.phone,
        required this.longitude,
        required this.latitude,
        required this.deliveryInstructions,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressTitle: json["addressTitle"],
        location: json["location"],
        customerName: json["customerName"],
        phone: json["phone"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        deliveryInstructions: json["deliveryInstructions"],
    );

    Map<String, dynamic> toJson() => {
        "addressTitle": addressTitle,
        "location": location,
        "customerName": customerName,
        "phone": phone,
        "longitude": longitude,
        "latitude": latitude,
        "deliveryInstructions": deliveryInstructions,
    };
}
