// To parse this JSON data, do
//
//     final promoCodeModel = promoCodeModelFromJson(jsonString);

import 'dart:convert';

List<PromoCodeModel> promoCodeModelFromJson(String str) =>
    List<PromoCodeModel>.from(
        json.decode(str).map((x) => PromoCodeModel.fromJson(x)));

String promoCodeModelToJson(List<PromoCodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromoCodeModel {
  final String id;
  final String code;
  final String description;
  final String discountType;
  final int discountValue;
  final DateTime expiryDate;
  final int usageLimit;
  final int usedCount;
  final bool isActive;
  final int v;

  PromoCodeModel({
    required this.id,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.expiryDate,
    required this.usageLimit,
    required this.usedCount,
    required this.isActive,
    required this.v,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
        id: json["_id"],
        code: json["code"],
        description: json["description"],
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        usageLimit: json["usageLimit"],
        usedCount: json["usedCount"],
        isActive: json["isActive"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "description": description,
        "discountType": discountType,
        "discountValue": discountValue,
        "expiryDate": expiryDate.toIso8601String(),
        "usageLimit": usageLimit,
        "usedCount": usedCount,
        "isActive": isActive,
        "__v": v,
      };
}
