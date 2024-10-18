// To parse this JSON data, do
//
//     final foodsModel = foodsModelFromJson(jsonString);

import 'dart:convert';

List<FoodsModel> foodsModelFromJson(String str) =>
    List<FoodsModel>.from(json.decode(str).map((x) => FoodsModel.fromJson(x)));

String foodsModelToJson(List<FoodsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodsModel {
  final String id;
  final String title;

  final String? type;
  final String category;
  final String code;
  final bool isAvailable;
  final int rating;
  final String ratingCount;
  final String description;
  final int price;
  final List<String> imageUrl;
  final String time;
  final DateTime createdAt;
  final DateTime updatedAt;

  FoodsModel({
    required this.id,
    required this.title,
    this.type,
    required this.category,
    required this.code,
    required this.isAvailable,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        category: json["category"],
        code: json["code"],
        isAvailable: json["isAvailable"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "category": category,
        "code": code,
        "isAvailable": isAvailable,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
